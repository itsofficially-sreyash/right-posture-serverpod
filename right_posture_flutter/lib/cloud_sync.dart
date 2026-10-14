import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_posture_client/right_posture_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/history.dart';
import 'domain/workout.dart';
import 'history_storage.dart';

/// Stable id for a workout, shared by the phone and the server. A workout's
/// completion time is unique per user and survives the JSON round trip.
String workoutClientId(HistoryWorkout workout) =>
    workout.completedAt.toUtc().toIso8601String();

/// Workout JSON for the server. Local history stores phone-local times
/// without an offset, so timestamps are sent as UTC to keep the server's
/// days, streaks and coach page correct in every timezone.
String encodeWorkoutPayload(HistoryWorkout workout) =>
    jsonEncode(_mapTimes(workout.toJson(), (t) => t.toUtc()));

/// Parses a server payload back into phone-local times.
HistoryWorkout? decodeWorkoutPayload(String payload) {
  try {
    final json = jsonDecode(payload) as Map<String, Object?>;
    return HistoryWorkout.tryParse(_mapTimes(json, (t) => t.toLocal()));
  } catch (_) {
    return null;
  }
}

Map<String, Object?> _mapTimes(
  Map<String, Object?> json,
  DateTime Function(DateTime) convert,
) {
  String? convertValue(Object? value) {
    if (value is! String) return null;
    final parsed = DateTime.tryParse(value);
    return parsed == null ? value : convert(parsed).toIso8601String();
  }

  return {
    ...json,
    'completedAt': convertValue(json['completedAt']),
    'sets': [
      for (final set in (json['sets'] as List<Object?>? ?? const []))
        if (set is Map<String, Object?>)
          {...set, 'completedAt': convertValue(set['completedAt'])}
        else
          set,
    ],
  };
}

/// The Serverpod calls cloud sync needs; a seam for tests.
abstract interface class CloudApi {
  bool get isSignedIn;
  Future<bool> upload(String clientId, String payload);
  Future<bool> updateNote(String clientId, String? note);
  Future<List<SyncedWorkout>> list();
}

class ServerpodCloudApi implements CloudApi {
  ServerpodCloudApi(this._client);

  final Client _client;

  @override
  bool get isSignedIn => _client.auth.isAuthenticated;

  @override
  Future<bool> upload(String clientId, String payload) =>
      _client.workout.upload(clientId, payload);

  @override
  Future<bool> updateNote(String clientId, String? note) =>
      _client.workout.updateNote(clientId, note);

  @override
  Future<List<SyncedWorkout>> list() => _client.workout.list();
}

enum CloudSyncPhase { signedOut, idle, syncing, synced, offline }

@immutable
class CloudSyncState {
  const CloudSyncState({required this.phase, this.lastSyncedAt, this.pending});

  final CloudSyncPhase phase;
  final DateTime? lastSyncedAt;

  /// Local workouts not yet confirmed by the server, when known.
  final int? pending;
}

/// Two-way sync between local summary history and the Serverpod backend.
///
/// Local storage stays the source the UI reads, so the app keeps working
/// offline. Every sync uploads workouts the server has not confirmed (the
/// server ignores duplicates) and restores workouts recorded on other devices.
class CloudSync extends ValueNotifier<CloudSyncState> {
  CloudSync({
    required HistoryStorage local,
    required CloudApi api,
    SharedPreferencesAsync? preferences,
    // ignore: prefer_initializing_formals
  }) : _local = local,
       _api = api,
       _preferences = preferences ?? SharedPreferencesAsync(),
       super(
         CloudSyncState(
           phase: api.isSignedIn
               ? CloudSyncPhase.idle
               : CloudSyncPhase.signedOut,
         ),
       );

  static const _uploadedKey = 'cloud.uploaded.v1';

  final HistoryStorage _local;
  final CloudApi _api;
  final SharedPreferencesAsync _preferences;
  Future<void>? _running;
  bool _again = false;

  /// Runs a sync, coalescing overlapping requests into one follow-up pass.
  Future<void> sync() {
    if (_running != null) {
      _again = true;
      return _running!;
    }
    return _running = _syncLoop().whenComplete(() => _running = null);
  }

  Future<void> _syncLoop() async {
    do {
      _again = false;
      await _syncOnce();
    } while (_again);
  }

  Future<void> _syncOnce() async {
    if (!_api.isSignedIn) {
      value = const CloudSyncState(phase: CloudSyncPhase.signedOut);
      return;
    }
    value = CloudSyncState(
      phase: CloudSyncPhase.syncing,
      lastSyncedAt: value.lastSyncedAt,
      pending: value.pending,
    );
    final uploaded = await _loadUploaded();
    try {
      for (final workout in await _local.load()) {
        final id = workoutClientId(workout);
        if (uploaded.contains(id)) continue;
        await _api.upload(id, encodeWorkoutPayload(workout));
        uploaded.add(id);
      }
      final remote = await _api.list();
      final restored = remote
          .map((item) => _parse(item.payload))
          .whereType<HistoryWorkout>()
          .toList(growable: false);
      uploaded.addAll(remote.map((item) => item.clientId));
      await _local.mergeWorkouts(restored);
      await _saveUploaded(uploaded);
      value = CloudSyncState(
        phase: CloudSyncPhase.synced,
        lastSyncedAt: DateTime.now(),
        pending: 0,
      );
    } catch (_) {
      await _saveUploaded(uploaded);
      final local = await _local.load();
      value = CloudSyncState(
        phase: CloudSyncPhase.offline,
        lastSyncedAt: value.lastSyncedAt,
        pending: local
            .where((workout) => !uploaded.contains(workoutClientId(workout)))
            .length,
      );
    }
  }

  /// Pushes an edited note; a failed push is retried by the next full sync
  /// only for new workouts, so notes are best-effort while offline.
  Future<void> pushNote(DateTime completedAt, String? note) async {
    if (!_api.isSignedIn) return;
    try {
      await _api.updateNote(completedAt.toUtc().toIso8601String(), note);
    } catch (_) {}
  }

  /// Forgets which workouts were confirmed, e.g. after switching accounts.
  Future<void> reset() async {
    await _preferences.remove(_uploadedKey);
    value = CloudSyncState(
      phase: _api.isSignedIn ? CloudSyncPhase.idle : CloudSyncPhase.signedOut,
    );
  }

  Future<Set<String>> _loadUploaded() async {
    try {
      return (await _preferences.getStringList(_uploadedKey) ?? const [])
          .toSet();
    } catch (_) {
      return <String>{};
    }
  }

  Future<void> _saveUploaded(Set<String> ids) async {
    try {
      await _preferences.setStringList(_uploadedKey, ids.toList()..sort());
    } catch (_) {}
  }

  static HistoryWorkout? _parse(String payload) =>
      decodeWorkoutPayload(payload);
}

/// [HistoryStorage] that triggers a cloud sync after every local write.
class SyncingHistoryStorage extends HistoryStorage {
  SyncingHistoryStorage(super._backend, {required this.cloud});

  final CloudSync Function() cloud;

  @override
  Future<void> saveWorkout(WorkoutState workout, {String? note}) async {
    await super.saveWorkout(workout, note: note);
    unawaited(cloud().sync());
  }

  @override
  Future<void> updateNote(DateTime completedAt, String? note) async {
    await super.updateNote(completedAt, note);
    unawaited(cloud().pushNote(completedAt, note));
  }
}

/// Provided in `main.dart`, where the Serverpod client exists.
final cloudSyncProvider = Provider<CloudSync>(
  (_) => throw UnimplementedError('cloudSyncProvider must be overridden'),
);
