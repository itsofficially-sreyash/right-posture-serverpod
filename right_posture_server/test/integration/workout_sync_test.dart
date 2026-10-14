import 'dart:convert';

import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _alice = '550e8400-e29b-41d4-a716-446655440000';
const _bob = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';

String workoutPayload(
  DateTime completedAt, {
  required double formScore,
  int totalReps = 8,
  String exercise = 'squat',
  String? note,
}) => jsonEncode({
  'completedAt': completedAt.toIso8601String(),
  'sets': [
    {
      'exercise': exercise,
      'completedAt': completedAt.toIso8601String(),
      'totalReps': totalReps,
      'outcomes': {
        'good': totalReps - 4,
        'warning': 0,
        'degraded': 1,
        'calibration': 3,
      },
      'formScore': formScore,
      'components': [
        {'id': 'range', 'label': 'Range', 'percent': formScore, 'count': 5},
      ],
      'averageRange': 92.0,
      'averageTempo': 2.4,
      'averageSymmetry': null,
      'consistency': 80.0,
      'degradationStartRep': 7,
      'issues': [
        {'metric': 'kneeAngle', 'direction': 'aboveRange', 'severity': 0.4},
      ],
      'feedback': ['Go lower'],
      'repOutcomes': [],
    },
  ],
  'note': ?note,
});

void main() {
  // One group on the configured test database (rolled back after each test).
  // A second embedded-PostgreSQL launch per group fails to re-attach on
  // Windows with Serverpod 4.0.4, so the ephemeral per-group database is off.
  withServerpod('Given the workout and progress endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    final alice = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_alice, {}),
    );
    final bob = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_bob, {}),
    );
    final first = DateTime.utc(2026, 10, 12, 8);

    test('then uploading the same workout twice stores it once', () async {
      final payload = workoutPayload(first, formScore: 70);
      expect(await endpoints.workout.upload(alice, 'w1', payload), isTrue);
      expect(await endpoints.workout.upload(alice, 'w1', payload), isFalse);

      final status = await endpoints.workout.status(alice);
      expect(status.workoutCount, 1);
      expect(status.setCount, 1);
      expect(status.totalReps, 8);
    });

    test('then workouts are private to their owner', () async {
      await endpoints.workout.upload(
        alice,
        'w1',
        workoutPayload(first, formScore: 70),
      );
      expect(await endpoints.workout.list(bob), isEmpty);
      final restored = await endpoints.workout.list(alice);
      expect(restored.single.clientId, 'w1');
    });

    test('then unreadable payloads are rejected', () async {
      await expectLater(
        endpoints.workout.upload(alice, 'bad', '{"sets": "nope"}'),
        throwsA(isA<ArgumentError>()),
      );
      expect((await endpoints.workout.status(alice)).workoutCount, 0);
    });

    test('then notes update the stored payload', () async {
      await endpoints.workout.upload(
        alice,
        'w1',
        workoutPayload(first, formScore: 70),
      );
      expect(
        await endpoints.workout.updateNote(alice, 'w1', ' Felt good '),
        isTrue,
      );
      final restored = await endpoints.workout.list(alice);
      final json = jsonDecode(restored.single.payload) as Map<String, Object?>;
      expect(json['note'], 'Felt good');
    });

    test('then deleteAll removes only the caller\'s data', () async {
      await endpoints.workout.upload(
        alice,
        'a',
        workoutPayload(first, formScore: 70),
      );
      await endpoints.workout.upload(
        bob,
        'b',
        workoutPayload(first, formScore: 70),
      );
      expect(await endpoints.workout.deleteAll(alice), 1);
      expect((await endpoints.workout.status(bob)).workoutCount, 1);
    });

    test('then unauthenticated calls are refused', () async {
      final anonymous = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.unauthenticated(),
      );
      await expectLater(
        endpoints.workout.list(anonymous),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test('then the report reflects every synced workout', () async {
      final now = DateTime.now().toUtc();
      await endpoints.workout.upload(
        alice,
        'w1',
        workoutPayload(now.subtract(const Duration(days: 1)), formScore: 60),
      );
      await endpoints.workout.upload(
        alice,
        'w2',
        workoutPayload(now, formScore: 80),
      );

      final report = await endpoints.progress.report(alice, 0);
      expect(report.workoutCount, 2);
      expect(report.totalReps, 16);
      expect(report.streakDays, 2);

      final squat = report.exercises.single;
      expect(squat.exercise, 'squat');
      expect(squat.averageFormScore, closeTo(70, 0.001));
      expect(squat.bestFormScore, 80);
      expect(squat.topIssueCount, 2);
      expect(
        squat.insights,
        contains(startsWith('Form score improved: 60% to 80%')),
      );
    });

    test('then an empty account gets an empty report', () async {
      final report = await endpoints.progress.report(alice, 330);
      expect(report.workoutCount, 0);
      expect(report.streakDays, 0);
      expect(report.exercises, isEmpty);
    });
  }, ephemeralDatabase: false);
}
