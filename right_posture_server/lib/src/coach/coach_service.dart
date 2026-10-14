import 'dart:math';

import 'package:right_posture_core/domain/history.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../progress/progress_report_builder.dart';
import '../workouts/workout_endpoint.dart';

/// Coach sharing rules shared by the RPC endpoints and the coach web page.
abstract final class CoachService {
  static const maxActiveShares = 10;
  static const maxLabelLength = 60;
  static const maxAuthorLength = 60;
  static const maxNoteLength = 1000;
  static const maxNotesPerShare = 200;
  static const recentWorkoutLimit = 10;

  // No 0/O/1/I/L so codes are easy to read aloud and type.
  static const _alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  static final _random = Random.secure();

  static String newCode() => List.generate(
    8,
    (_) => _alphabet[_random.nextInt(_alphabet.length)],
  ).join();

  /// Normalises user input like "abcd-2345 " to "ABCD2345".
  static String normalizeCode(String code) =>
      code.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

  /// Public URL of the physio page for [code], on the web server.
  static String shareUrl(Session session, String code) {
    final web = session.serverpod.config.webServer;
    if (web == null) return code;
    final defaultPort =
        (web.publicScheme == 'https' && web.publicPort == 443) ||
        (web.publicScheme == 'http' && web.publicPort == 80);
    return Uri(
      scheme: web.publicScheme,
      host: web.publicHost,
      port: defaultPort ? null : web.publicPort,
      path: '/physio/$code',
    ).toString();
  }

  /// The active (not revoked) share for [code], or null.
  static Future<CoachShare?> findActive(Session session, String code) {
    final normalized = normalizeCode(code);
    if (normalized.length != 8) return Future.value(null);
    return CoachShare.db.findFirstRow(
      session,
      where: (t) => t.code.equals(normalized) & t.revokedAt.equals(null),
    );
  }

  /// Builds what a coach sees and records the view.
  static Future<SharedProgress> sharedProgress(
    Session session,
    CoachShare share, {
    required int utcOffsetMinutes,
  }) async {
    await CoachShare.db.updateRow(
      session,
      share.copyWith(
        viewCount: share.viewCount + 1,
        lastViewedAt: DateTime.now().toUtc(),
      ),
    );

    final records = await WorkoutRecord.db.find(
      session,
      where: (t) => t.authUserId.equals(share.authUserId),
      orderBy: (t) => t.completedAt,
    );
    final workouts = records
        .map((record) => parseWorkout(record.payload))
        .nonNulls
        .toList(growable: false);
    final report = buildProgressReport(
      workouts,
      now: DateTime.now().toUtc(),
      utcOffset: Duration(minutes: utcOffsetMinutes.clamp(-14 * 60, 14 * 60)),
    );
    final notes = await CoachNote.db.find(
      session,
      where: (t) => t.shareId.equals(share.id!),
      orderBy: (t) => t.createdAt.desc(),
      limit: 20,
    );
    return SharedProgress(
      label: share.label,
      report: report,
      recentWorkouts: workouts.reversed
          .take(recentWorkoutLimit)
          .map(_summarize)
          .toList(),
      notes: [
        for (final note in notes)
          SharedNote(
            authorName: note.authorName,
            message: note.message,
            createdAt: note.createdAt,
          ),
      ],
    );
  }

  /// Stores a coach note. Returns false when the share no longer accepts notes.
  static Future<bool> addNote(
    Session session,
    CoachShare share, {
    required String authorName,
    required String message,
  }) async {
    final author = authorName.trim();
    final text = message.trim();
    if (author.isEmpty || author.length > maxAuthorLength) {
      throw ArgumentError.value(authorName, 'authorName', 'Invalid name');
    }
    if (text.isEmpty || text.length > maxNoteLength) {
      throw ArgumentError.value(message, 'message', 'Invalid message');
    }
    final count = await CoachNote.db.count(
      session,
      where: (t) => t.shareId.equals(share.id!),
    );
    if (count >= maxNotesPerShare) return false;
    await CoachNote.db.insertRow(
      session,
      CoachNote(shareId: share.id!, authorName: author, message: text),
    );
    return true;
  }

  static SharedWorkout _summarize(HistoryWorkout workout) {
    final scores = workout.sets
        .map((set) => set.formScorePercent)
        .whereType<double>()
        .toList(growable: false);
    return SharedWorkout(
      completedAt: workout.completedAt.toUtc(),
      exercises: workout.sets.map((set) => set.exercise.name).toSet().toList(),
      sets: workout.sets.length,
      totalReps: workout.sets.fold(0, (sum, set) => sum + set.totalReps),
      averageFormScore: scores.isEmpty
          ? null
          : scores.reduce((a, b) => a + b) / scores.length,
      degradedReps: workout.sets.fold(0, (sum, set) => sum + set.degradedReps),
      note: workout.note,
    );
  }
}
