import 'dart:math';

import 'domain/history.dart';
import 'history_storage.dart';

/// Builds with `--dart-define=DEMO_SEED=true` start with a week of fictional
/// workouts so screenshots and demos show populated screens. Never enabled in
/// normal builds.
const demoSeedEnabled = bool.fromEnvironment('DEMO_SEED');

Future<void> seedDemoHistory(HistoryStorage storage) async {
  if ((await storage.load()).isNotEmpty) return;
  final now = DateTime.now();
  final random = Random(7);
  final plan = [
    (6, 'squat', 68.0, 'First session, felt stiff'),
    (5, 'bicepCurl', 71.0, null),
    (4, 'squat', 74.0, null),
    (3, 'shoulderPress', 70.0, 'Used 5 kg dumbbells'),
    (2, 'squat', 79.0, null),
    (1, 'bicepCurl', 81.0, null),
    (0, 'squat', 86.0, 'Best depth so far'),
  ];
  final workouts = <HistoryWorkout>[];
  for (final (daysAgo, exercise, score, note) in plan) {
    final at = DateTime(now.year, now.month, now.day, 7, 30)
        .subtract(Duration(days: daysAgo))
        .add(Duration(minutes: random.nextInt(40)));
    final sets = [
      for (var i = 0; i < 2; i++)
        _set(
          exercise,
          at.add(Duration(minutes: 4 * i)),
          score - i * 3 + random.nextDouble() * 2,
          degradeFrom: i == 1 ? 8 : null,
        ),
    ];
    final workout = HistoryWorkout.tryParse({
      'completedAt': sets.last['completedAt'],
      'sets': sets,
      'note': ?note,
    });
    if (workout != null) workouts.add(workout);
  }
  await storage.mergeWorkouts(workouts);
}

Map<String, Object?> _set(
  String exercise,
  DateTime at,
  double score, {
  int? degradeFrom,
}) {
  const reps = 10;
  final metric = switch (exercise) {
    'squat' => 'kneeAngle',
    'bicepCurl' => 'leftElbowAngle',
    _ => 'armElevation',
  };
  final statuses = [
    for (var n = 1; n <= reps; n++)
      n <= 3
          ? 'calibrating'
          : degradeFrom != null && n >= degradeFrom
          ? 'degraded'
          : n == 6
          ? 'warning'
          : 'good',
  ];
  Map<String, Object?> issue(String direction, double severity) => {
    'metric': metric,
    'direction': direction,
    'severity': severity,
  };
  return {
    'exercise': exercise,
    'completedAt': at.toIso8601String(),
    'totalReps': reps,
    'outcomes': {
      'good': statuses.where((s) => s == 'good').length,
      'warning': statuses.where((s) => s == 'warning').length,
      'degraded': statuses.where((s) => s == 'degraded').length,
      'calibration': 3,
    },
    'formScore': score,
    'components': [
      {
        'id': 'range',
        'label': 'Range consistency',
        'percent': score + 4,
        'count': 7,
      },
      {
        'id': 'tempo',
        'label': 'Tempo consistency',
        'percent': score - 5,
        'count': 7,
      },
      {
        'id': 'control',
        'label': 'Control / return consistency',
        'percent': score,
        'count': 7,
      },
    ],
    'averageRange': exercise == 'squat' ? 92.0 + score / 10 : 118.0,
    'averageTempo': 2.6 - score / 100,
    'averageSymmetry': exercise == 'squat' ? null : 0.12,
    'consistency': score + 2,
    'degradationStartRep': degradeFrom,
    'issues': [
      issue('belowRange', 0.4),
      if (degradeFrom != null) issue('decreased', 0.6),
    ],
    'feedback': [
      exercise == 'squat' ? 'Go a little lower' : 'Control the lowering phase',
    ],
    'repOutcomes': [
      for (var n = 1; n <= reps; n++)
        {
          'number': n,
          'status': statuses[n - 1],
          'issues': statuses[n - 1] == 'degraded'
              ? [issue('decreased', 0.6)]
              : statuses[n - 1] == 'warning'
              ? [issue('belowRange', 0.4)]
              : <Object?>[],
        },
    ],
  };
}
