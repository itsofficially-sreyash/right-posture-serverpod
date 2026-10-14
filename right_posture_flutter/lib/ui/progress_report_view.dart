import 'package:flutter/material.dart';
import 'package:right_posture_client/right_posture_client.dart';

import '../domain/exercise.dart';
import '../domain/exercise_registry.dart';
import 'app_theme.dart';

/// Server progress report widgets shared by the account and coach screens.
class ProgressReportView extends StatelessWidget {
  const ProgressReportView({super.key, required this.report});

  final ProgressReport report;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            StatTile(label: 'Sessions', value: '${report.workoutCount}'),
            StatTile(label: 'Sets', value: '${report.setCount}'),
            StatTile(label: 'Reps', value: '${report.totalReps}'),
            StatTile(label: 'Day streak', value: '${report.streakDays}'),
            StatTile(
              label: 'Active days (28)',
              value: '${report.activeDaysLast28}',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        if (report.exercises.isEmpty)
          const InfoCard(
            icon: Icons.insights,
            text: 'No synced sessions yet.',
          )
        else
          for (final exercise in report.exercises) ...[
            ExerciseProgressCard(progress: exercise),
            const SizedBox(height: AppSpacing.small),
          ],
      ],
    );
  }
}

/// Display name for an `ExerciseId` name sent by the server.
String exerciseDisplayName(String id) {
  final match = ExerciseId.values.where((e) => e.name == id);
  if (match.isEmpty) return id;
  try {
    return const ExerciseRegistry().profileFor(match.first).displayName;
  } catch (_) {
    return id;
  }
}

class ExerciseProgressCard extends StatelessWidget {
  const ExerciseProgressCard({super.key, required this.progress});

  final ExerciseProgress progress;

  String get _name => exerciseDisplayName(progress.exercise);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String percent(double? value) =>
        value == null ? '—' : '${value.toStringAsFixed(0)}%';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_name, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.small),
            Text(
              '${progress.sets} sets · ${progress.reps} reps · '
              'avg form ${percent(progress.averageFormScore)} · '
              'best ${percent(progress.bestFormScore)}',
              style: textTheme.bodyLarge,
            ),
            Text(
              'This week: ${progress.weeklySets} sets, '
              '${progress.weeklyReps} reps, form '
              '${percent(progress.weeklyFormScore)}',
              style: textTheme.bodyMedium,
            ),
            Text(
              'Reps: ${progress.goodReps} good · ${progress.warningReps} '
              'warning · ${progress.degradedReps} degraded',
              style: textTheme.bodyMedium,
            ),
            if (progress.topIssue != null)
              Text(
                'Most frequent issue: ${progress.topIssue} '
                '(${progress.topIssueCount}×)',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.warning),
              ),
            for (final insight in progress.insights)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.base),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.insights, size: 18, color: AppColors.lime),
                    const SizedBox(width: AppSpacing.small),
                    Expanded(child: Text(insight, style: textTheme.bodyMedium)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 96),
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.lime,
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMuted),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
