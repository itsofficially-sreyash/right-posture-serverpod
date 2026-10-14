/// End-to-end smoke test for a running Right Posture server:
/// guest sign-in, two uploads, a duplicate upload, status, progress report
/// and a coach share link with a note.
///
/// Usage: dart run tool/smoke.dart [server-url]
import 'dart:convert';

import 'package:right_posture_client/right_posture_client.dart';

Future<void> main(List<String> args) async {
  final url = args.isEmpty ? 'http://localhost:8080/' : args.first;
  final client = Client(url);
  final auth = await client.anonymousIdp.login();
  client.authKeyProvider = _Key(auth.token);
  final now = DateTime.now().toUtc();
  String payload(DateTime at, double score) => jsonEncode({
    'completedAt': at.toIso8601String(),
    'sets': [
      {
        'exercise': 'squat',
        'completedAt': at.toIso8601String(),
        'totalReps': 10,
        'outcomes': {'good': 6, 'warning': 1, 'degraded': 0, 'calibration': 3},
        'formScore': score,
        'components': [],
        'averageRange': 95.0,
        'averageTempo': 2.1,
        'averageSymmetry': null,
        'consistency': 85.0,
        'degradationStartRep': null,
        'issues': [],
        'feedback': [],
        'repOutcomes': [],
      },
    ],
  });
  final a = now.subtract(const Duration(days: 1));
  print(
    'upload1 ${await client.workout.upload(a.toIso8601String(), payload(a, 72))}',
  );
  print(
    'upload2 ${await client.workout.upload(now.toIso8601String(), payload(now, 84))}',
  );
  print(
    'dup ${await client.workout.upload(now.toIso8601String(), payload(now, 84))}',
  );
  final s = await client.workout.status();
  print(
    'status workouts=${s.workoutCount} sets=${s.setCount} reps=${s.totalReps}',
  );
  final r = await client.progress.report(330);
  print(
    'report streak=${r.streakDays} exercises=${r.exercises.map((e) => '${e.exercise}:${e.averageFormScore}').join(',')}',
  );
  print('insights ${r.exercises.first.insights}');
  final share = await client.coach.createShare('Coach Smoke');
  print('coach link ${share.url}');
  final note = await client.coachView.leaveNote(
    share.code,
    'Smoke',
    'Looks good.',
  );
  print('coach note $note, notes=${(await client.coach.notes()).length}');
  client.close();
}

class _Key implements ClientAuthKeyProvider {
  _Key(this.token);
  final String token;
  @override
  Future<String?> get authHeaderValue async =>
      wrapAsBearerAuthHeaderValue(token);
}
