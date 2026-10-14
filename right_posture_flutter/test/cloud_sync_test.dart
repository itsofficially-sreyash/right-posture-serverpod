import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:right_posture_client/right_posture_client.dart';
import 'package:right_posture_flutter/cloud_sync.dart';
import 'package:right_posture_flutter/domain/history.dart';
import 'package:right_posture_flutter/history_storage.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'history_storage_test.dart' show MemoryHistoryBackend, sampleWorkout;

class FakeCloudApi implements CloudApi {
  final stored = <String, String>{};
  final uploads = <String>[];
  bool online = true;
  bool signedIn = true;

  @override
  bool get isSignedIn => signedIn;

  @override
  Future<bool> upload(String clientId, String payload) async {
    if (!online) throw Exception('offline');
    uploads.add(clientId);
    return stored.putIfAbsent(clientId, () => payload) == payload;
  }

  @override
  Future<bool> updateNote(String clientId, String? note) async => true;

  @override
  Future<List<SyncedWorkout>> list() async {
    if (!online) throw Exception('offline');
    return [
      for (final entry in stored.entries)
        SyncedWorkout(clientId: entry.key, payload: entry.value),
    ];
  }
}

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('uploads local workouts once and marks them synced', () async {
    final local = HistoryStorage(MemoryHistoryBackend());
    final api = FakeCloudApi();
    final cloud = CloudSync(local: local, api: api);
    await local.saveWorkout(sampleWorkout(day: 1));
    await local.saveWorkout(sampleWorkout(day: 2));

    await cloud.sync();
    await cloud.sync();

    expect(api.uploads, hasLength(2));
    expect(cloud.value.phase, CloudSyncPhase.synced);
    expect(cloud.value.pending, 0);
  });

  test('queues workouts while offline and uploads them later', () async {
    final local = HistoryStorage(MemoryHistoryBackend());
    final api = FakeCloudApi()..online = false;
    final cloud = CloudSync(local: local, api: api);
    await local.saveWorkout(sampleWorkout(day: 1));

    await cloud.sync();
    expect(cloud.value.phase, CloudSyncPhase.offline);
    expect(cloud.value.pending, 1);

    api.online = true;
    await cloud.sync();
    expect(api.stored, hasLength(1));
    expect(cloud.value.phase, CloudSyncPhase.synced);
  });

  test('restores workouts from another device without duplicates', () async {
    final api = FakeCloudApi();
    final otherDevice = HistoryWorkout.fromCompletedSets(
      sampleWorkout(day: 3).completedSets,
    );
    api.stored[workoutClientId(otherDevice)] = jsonEncode(
      otherDevice.toJson(),
    );
    final local = HistoryStorage(MemoryHistoryBackend());
    await local.saveWorkout(sampleWorkout(day: 1));
    final cloud = CloudSync(local: local, api: api);

    await cloud.sync();
    await cloud.sync();

    final history = await local.load();
    expect(history.map((w) => w.completedAt.day), [1, 3]);
    expect(api.stored, hasLength(2));
  });

  test('payload timestamps are UTC and restore to local time', () {
    final workout = HistoryWorkout.fromCompletedSets(
      sampleWorkout(day: 2).completedSets,
    );
    final payload = encodeWorkoutPayload(workout);
    final json = jsonDecode(payload) as Map<String, Object?>;
    expect(json['completedAt'] as String, endsWith('Z'));
    final sets = json['sets'] as List<Object?>;
    expect((sets.single as Map)['completedAt'] as String, endsWith('Z'));

    final restored = decodeWorkoutPayload(payload)!;
    expect(restored.completedAt.isUtc, isFalse);
    expect(restored.completedAt, workout.completedAt);
    expect(restored.sets.single.completedAt, workout.sets.single.completedAt);
  });

  test('signed-out users never call the server', () async {
    final api = FakeCloudApi()..signedIn = false;
    final local = HistoryStorage(MemoryHistoryBackend());
    await local.saveWorkout(sampleWorkout(day: 1));
    final cloud = CloudSync(local: local, api: api);

    await cloud.sync();

    expect(api.uploads, isEmpty);
    expect(cloud.value.phase, CloudSyncPhase.signedOut);
  });

  test('saving through SyncingHistoryStorage triggers an upload', () async {
    final api = FakeCloudApi();
    late final CloudSync cloud;
    final local = SyncingHistoryStorage(
      MemoryHistoryBackend(),
      cloud: () => cloud,
    );
    cloud = CloudSync(local: local, api: api);

    await local.saveWorkout(sampleWorkout(day: 1));
    await cloud.sync();

    expect(api.stored, hasLength(1));
  });
}
