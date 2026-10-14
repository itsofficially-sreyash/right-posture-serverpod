import 'dart:convert';

import 'package:right_posture_core/domain/history.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Cloud backup for finished workouts.
///
/// The app uploads the same bounded summary JSON it keeps locally. The server
/// validates it with the shared core engine, stores it once per `clientId`, and
/// indexes every set so progress can be queried across devices.
class WorkoutEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const maxPayloadLength = 256 * 1024;
  static const listLimit = 500;

  /// Stores a workout. Uploading the same `clientId` again is a no-op, so the
  /// app can safely retry after a lost connection. Returns true when stored.
  Future<bool> upload(Session session, String clientId, String payload) async {
    final userId = _userId(session);
    if (clientId.isEmpty || clientId.length > 64) {
      throw ArgumentError.value(clientId, 'clientId', 'Invalid workout id');
    }
    if (payload.length > maxPayloadLength) {
      throw ArgumentError.value(payload.length, 'payload', 'Workout too large');
    }
    final workout = parseWorkout(payload);
    if (workout == null) {
      throw ArgumentError.value(clientId, 'payload', 'Unreadable workout');
    }

    return session.db.transaction((transaction) async {
      final existing = await WorkoutRecord.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(userId) & t.clientId.equals(clientId),
        transaction: transaction,
      );
      if (existing != null) return false;

      final scores = workout.sets
          .map((set) => set.formScorePercent)
          .whereType<double>()
          .toList(growable: false);
      final record = await WorkoutRecord.db.insertRow(
        session,
        WorkoutRecord(
          authUserId: userId,
          clientId: clientId,
          completedAt: workout.completedAt.toUtc(),
          note: workout.note,
          setCount: workout.sets.length,
          totalReps: workout.sets.fold(0, (sum, set) => sum + set.totalReps),
          averageFormScore: scores.isEmpty
              ? null
              : scores.reduce((a, b) => a + b) / scores.length,
          payload: payload,
        ),
        transaction: transaction,
      );
      await WorkoutSetRecord.db.insert(session, [
        for (final set in workout.sets)
          WorkoutSetRecord(
            workoutId: record.id!,
            authUserId: userId,
            exercise: set.exercise.name,
            completedAt: set.completedAt.toUtc(),
            totalReps: set.totalReps,
            goodReps: set.goodReps,
            warningReps: set.warningReps,
            degradedReps: set.degradedReps,
            formScore: set.formScorePercent,
            consistencyScore: set.consistencyScorePercent,
            degradationStartRep: set.degradationStartRep,
          ),
      ], transaction: transaction);
      return true;
    });
  }

  /// Updates the journal note of a synced workout.
  Future<bool> updateNote(
    Session session,
    String clientId,
    String? note,
  ) async {
    final userId = _userId(session);
    final record = await WorkoutRecord.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId) & t.clientId.equals(clientId),
    );
    if (record == null) return false;
    final workout = parseWorkout(record.payload);
    if (workout == null) return false;
    final trimmed = note?.trim();
    final cleaned = trimmed == null || trimmed.isEmpty ? null : trimmed;
    final updated = HistoryWorkout(
      completedAt: workout.completedAt,
      sets: workout.sets,
      note: cleaned,
    );
    await WorkoutRecord.db.updateRow(
      session,
      record.copyWith(note: cleaned, payload: jsonEncode(updated.toJson())),
    );
    return true;
  }

  /// Returns the user's most recent workouts, oldest first, for restoring
  /// local history on any device.
  Future<List<SyncedWorkout>> list(Session session) async {
    final userId = _userId(session);
    final records = await WorkoutRecord.db.find(
      session,
      where: (t) => t.authUserId.equals(userId),
      orderBy: (t) => t.completedAt.desc(),
      limit: listLimit,
    );
    return records.reversed
        .map((r) => SyncedWorkout(clientId: r.clientId, payload: r.payload))
        .toList();
  }

  /// Totals for the account screen.
  Future<SyncStatus> status(Session session) async {
    final userId = _userId(session);
    final workoutCount = await WorkoutRecord.db.count(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final sets = await WorkoutSetRecord.db.find(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final latest = await WorkoutRecord.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      orderBy: (t) => t.completedAt.desc(),
    );
    return SyncStatus(
      workoutCount: workoutCount,
      setCount: sets.length,
      totalReps: sets.fold(0, (sum, set) => sum + set.totalReps),
      lastCompletedAt: latest?.completedAt,
    );
  }

  /// Deletes every synced workout of the signed-in user.
  Future<int> deleteAll(Session session) async {
    final userId = _userId(session);
    final deleted = await WorkoutRecord.db.deleteWhere(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    return deleted.length;
  }
}

UuidValue _userId(Session session) => session.authenticated!.authUserId;

/// Parses a stored workout payload with the shared core engine.
HistoryWorkout? parseWorkout(String payload) {
  try {
    return HistoryWorkout.tryParse(jsonDecode(payload));
  } catch (_) {
    return null;
  }
}
