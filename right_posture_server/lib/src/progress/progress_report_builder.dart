import 'package:right_posture_core/domain/analytics.dart';
import 'package:right_posture_core/domain/analytics_insights.dart';
import 'package:right_posture_core/domain/exercise.dart';
import 'package:right_posture_core/domain/feedback_catalog.dart';
import 'package:right_posture_core/domain/history.dart';

import '../generated/protocol.dart';

/// Builds a [ProgressReport] with the same core analytics the app uses.
///
/// The core engine groups days with `toLocal()`, which is UTC on the server,
/// so timestamps are shifted by the user's [utcOffset] first.
ProgressReport buildProgressReport(
  List<HistoryWorkout> workouts, {
  required DateTime now,
  required Duration utcOffset,
}) {
  final shifted = workouts.map((w) => _shift(w, utcOffset)).toList();
  final localNow = now.toUtc().add(utcOffset);
  final today = DateTime.utc(localNow.year, localNow.month, localNow.day);
  final days = shifted
      .map((w) => w.completedAt)
      .map((d) => DateTime.utc(d.year, d.month, d.day))
      .toSet();
  final latestDay = days.isEmpty
      ? null
      : days.reduce((a, b) => a.isAfter(b) ? a : b);
  final streakIsCurrent =
      latestDay != null && today.difference(latestDay).inDays <= 1;
  final activeDays = days
      .where((day) => today.difference(day).inDays < 28)
      .length;

  final exercises = <ExerciseProgress>[];
  for (final exercise in ExerciseId.values) {
    final sets = historyForExercise(shifted, exercise);
    if (sets.isEmpty) continue;
    final quality = qualityDistribution(shifted, exercise);
    final weekly = weeklySummary(shifted, exercise, now: localNow);
    final scores = sets
        .map((set) => set.formScorePercent)
        .whereType<double>()
        .toList(growable: false);
    final issues = issueFrequency(shifted, exercise).entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    exercises.add(
      ExerciseProgress(
        exercise: exercise.name,
        sets: sets.length,
        reps: sets.fold(0, (sum, set) => sum + set.totalReps),
        goodReps: quality.good,
        warningReps: quality.warning,
        degradedReps: quality.degraded,
        averageFormScore: scores.isEmpty
            ? null
            : scores.reduce((a, b) => a + b) / scores.length,
        bestFormScore: bestSet(shifted, exercise)?.set.formScorePercent,
        weeklySets: weekly.sets,
        weeklyReps: weekly.reps,
        weeklyFormScore: weekly.averageFormScore,
        topIssue: issues.isEmpty ? null : metricLabel(issues.first.key),
        topIssueCount: issues.isEmpty ? 0 : issues.first.value,
        insights: [
          for (final insight in progressInsights(shifted, exercise))
            describeInsight(insight),
        ],
      ),
    );
  }
  exercises.sort((a, b) => b.sets.compareTo(a.sets));

  return ProgressReport(
    generatedAt: now.toUtc(),
    workoutCount: workouts.length,
    setCount: exercises.fold(0, (sum, e) => sum + e.sets),
    totalReps: exercises.fold(0, (sum, e) => sum + e.reps),
    streakDays: streakIsCurrent ? latestActivityStreak(shifted) : 0,
    activeDaysLast28: activeDays,
    exercises: exercises,
  );
}

HistoryWorkout _shift(HistoryWorkout workout, Duration offset) =>
    HistoryWorkout(
      completedAt: workout.completedAt.toUtc().add(offset),
      note: workout.note,
      sets: [
        for (final set in workout.sets)
          HistorySet(
            exercise: set.exercise,
            completedAt: set.completedAt.toUtc().add(offset),
            totalReps: set.totalReps,
            goodReps: set.goodReps,
            warningReps: set.warningReps,
            degradedReps: set.degradedReps,
            calibrationReps: set.calibrationReps,
            formScorePercent: set.formScorePercent,
            componentScores: set.componentScores,
            averageRange: set.averageRange,
            averageTempoSeconds: set.averageTempoSeconds,
            averageSymmetrySeconds: set.averageSymmetrySeconds,
            consistencyScorePercent: set.consistencyScorePercent,
            degradationStartRep: set.degradationStartRep,
            issues: set.issues,
            feedback: set.feedback,
            repOutcomes: set.repOutcomes,
          ),
      ],
    );

/// Plain-language sentence for a core [MetricInsight].
String describeInsight(MetricInsight insight) {
  final label = switch (insight.metric) {
    AnalyticsMetric.formScore => 'Form score',
    AnalyticsMetric.rangeOfMotion => 'Range of motion',
    AnalyticsMetric.tempo => 'Tempo',
    AnalyticsMetric.degradationPoint => 'Form held until rep',
    AnalyticsMetric.symmetry => 'Left/right timing gap',
    AnalyticsMetric.consistency => 'Consistency',
  };
  final seconds =
      insight.metric == AnalyticsMetric.symmetry ||
      insight.metric == AnalyticsMetric.tempo;
  final percent =
      insight.metric == AnalyticsMetric.formScore ||
      insight.metric == AnalyticsMetric.consistency;
  String format(double value) => seconds
      ? '${value.toStringAsFixed(2)} s'
      : percent
      ? '${value.toStringAsFixed(0)}%'
      : value.toStringAsFixed(0);
  final verb = switch (insight.direction) {
    InsightDirection.improved => 'improved',
    InsightDirection.declined => 'declined',
    InsightDirection.unchanged => 'held steady',
  };
  return '$label $verb: ${format(insight.previousValue)} to '
      '${format(insight.currentValue)} across your last two sets.';
}
