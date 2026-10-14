import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';
import 'workout_sync_test.dart' show workoutPayload;

const _athlete = '550e8400-e29b-41d4-a716-446655440000';
const _other = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';

void main() {
  // See workout_sync_test.dart for why the ephemeral database is off.
  withServerpod('Given coach sharing', (sessionBuilder, endpoints) {
    final athlete = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_athlete, {}),
    );
    final other = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_other, {}),
    );
    final coach = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.unauthenticated(),
    );

    test(
      'then a coach sees the athlete\'s progress through the code',
      () async {
        await endpoints.workout.upload(
          athlete,
          'w1',
          workoutPayload(DateTime.now().toUtc(), formScore: 75),
        );
        final share = await endpoints.coach.createShare(athlete, 'Coach Priya');
        expect(share.code, hasLength(8));
        expect(share.url, endsWith('/physio/${share.code}'));

        final view = await endpoints.coachView.view(
          coach,
          share.code.toLowerCase(),
          330,
        );
        expect(view, isNotNull);
        expect(view!.label, 'Coach Priya');
        expect(view.report.workoutCount, 1);
        expect(view.recentWorkouts.single.exercises, ['squat']);

        final listed = await endpoints.coach.listShares(athlete);
        expect(listed.single.viewCount, 1);
      },
    );

    test('then coach notes reach the athlete and can be marked read', () async {
      final share = await endpoints.coach.createShare(athlete, 'Coach Priya');
      expect(
        await endpoints.coachView.leaveNote(
          coach,
          share.code,
          'Priya',
          'Slow the lowering phase.',
        ),
        isTrue,
      );

      final notes = await endpoints.coach.notes(athlete);
      expect(notes.single.message, 'Slow the lowering phase.');
      expect(notes.single.read, isFalse);
      expect(
        (await endpoints.coach.listShares(athlete)).single.unreadNoteCount,
        1,
      );

      expect(await endpoints.coach.markNotesRead(athlete), 1);
      expect((await endpoints.coach.notes(athlete)).single.read, isTrue);
      expect(await endpoints.coach.notes(other), isEmpty);
    });

    test('then revoked or unknown codes show nothing', () async {
      final share = await endpoints.coach.createShare(athlete, 'Coach Priya');
      expect(await endpoints.coach.revokeShare(other, share.code), isFalse);
      expect(await endpoints.coach.revokeShare(athlete, share.code), isTrue);

      expect(await endpoints.coachView.view(coach, share.code, 0), isNull);
      expect(await endpoints.coachView.view(coach, 'NOPE2345', 0), isNull);
      expect(
        await endpoints.coachView.leaveNote(coach, share.code, 'X', 'Hi'),
        isFalse,
      );
      expect(await endpoints.coach.listShares(athlete), isEmpty);
    });

    test('then invalid names and notes are rejected', () async {
      await expectLater(
        endpoints.coach.createShare(athlete, '   '),
        throwsA(isA<ArgumentError>()),
      );
      final share = await endpoints.coach.createShare(athlete, 'Coach');
      await expectLater(
        endpoints.coachView.leaveNote(coach, share.code, 'Priya', ''),
        throwsA(isA<ArgumentError>()),
      );
    });
  }, ephemeralDatabase: false);
}
