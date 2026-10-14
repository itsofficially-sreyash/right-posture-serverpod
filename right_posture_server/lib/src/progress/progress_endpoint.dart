import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../workouts/workout_endpoint.dart';
import 'progress_report_builder.dart';

/// Progress analytics computed on the server from every synced workout.
class ProgressEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Builds the user's progress report. [utcOffsetMinutes] is the phone's
  /// timezone offset so days, weeks and streaks match the user's calendar.
  Future<ProgressReport> report(Session session, int utcOffsetMinutes) async {
    final userId = session.authenticated!.authUserId;
    final records = await WorkoutRecord.db.find(
      session,
      where: (t) => t.authUserId.equals(userId),
      orderBy: (t) => t.completedAt,
    );
    final workouts = records
        .map((record) => parseWorkout(record.payload))
        .nonNulls
        .toList(growable: false);
    return buildProgressReport(
      workouts,
      now: DateTime.now().toUtc(),
      utcOffset: Duration(minutes: utcOffsetMinutes.clamp(-14 * 60, 14 * 60)),
    );
  }
}
