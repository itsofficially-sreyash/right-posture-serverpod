import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_posture_client/right_posture_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client.dart';
import '../cloud_sync.dart';
import 'app_theme.dart';
import 'auth_gate.dart';
import 'progress_report_view.dart';
import 'settings_page.dart';

/// Account, cloud backup status and the server-computed progress report.
class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  Future<({SyncStatus status, ProgressReport report})>? _cloud;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_refresh);
    _refresh();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (!mounted) return;
    setState(() {
      _cloud = client.auth.isAuthenticated ? _loadCloud() : null;
    });
  }

  Future<({SyncStatus status, ProgressReport report})> _loadCloud() async {
    await ref.read(cloudSyncProvider).sync();
    final offset = DateTime.now().timeZoneOffset.inMinutes;
    final results = await Future.wait([
      client.workout.status(),
      client.progress.report(offset),
    ]);
    return (
      status: results[0] as SyncStatus,
      report: results[1] as ProgressReport,
    );
  }

  Future<void> _signOut() async {
    await client.auth.signOutDevice();
    _refresh();
  }

  Future<void> _signIn() async {
    try {
      await SharedPreferencesAsync().setBool(AuthGate.offlineKey, false);
    } catch (_) {}
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SignInRoute(),
      ),
    );
    _refresh();
  }

  Future<void> _deleteCloudData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete cloud backup?'),
        content: const Text(
          'Removes every workout summary stored on the server for this '
          'account. Workouts on this phone are kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await client.workout.deleteAll();
    await ref.read(cloudSyncProvider).reset();
    if (!mounted) return;
    setState(() {
      _cloud =
          Future.wait([
            client.workout.status(),
            client.progress.report(DateTime.now().timeZoneOffset.inMinutes),
          ]).then(
            (r) => (status: r[0] as SyncStatus, report: r[1] as ProgressReport),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cloud = ref.watch(cloudSyncProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: RefreshIndicator(
              onRefresh: () async {
                _refresh();
                try {
                  await _cloud;
                } catch (_) {}
              },
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.medium),
                children: [
                  Card(
                    child: ListTile(
                      key: const Key('profile_coaching_settings'),
                      leading: const Icon(Icons.tune, color: AppColors.lime),
                      title: const Text('Coaching settings'),
                      subtitle: const Text('Voice, haptic and sound cues'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              const SettingsPage(showAccount: false),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  if (!client.auth.isAuthenticated)
                    SignedOutCard(onSignIn: _signIn)
                  else ...[
                    ValueListenableBuilder(
                      valueListenable: cloud,
                      builder: (context, state, _) => _SyncCard(
                        state: state,
                        onSyncNow: _refresh,
                        onSignOut: _signOut,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    FutureBuilder(
                      future: _cloud,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const InfoCard(
                            icon: Icons.cloud_off,
                            text:
                                'The server is unreachable. Workouts stay on '
                                'this phone and upload when you are back '
                                'online.',
                          );
                        }
                        final data = snapshot.data;
                        if (data == null) {
                          return const Padding(
                            padding: EdgeInsets.all(AppSpacing.large),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _ReportView(
                          status: data.status,
                          report: data.report,
                          onDelete: _deleteCloudData,
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SyncCard extends StatelessWidget {
  const _SyncCard({
    required this.state,
    required this.onSyncNow,
    required this.onSignOut,
  });

  final CloudSyncState state;
  final VoidCallback onSyncNow;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final (icon, color, label) = switch (state.phase) {
      CloudSyncPhase.syncing => (Icons.sync, AppColors.cyan, 'Syncing…'),
      CloudSyncPhase.synced => (
        Icons.cloud_done,
        AppColors.success,
        'Backed up',
      ),
      CloudSyncPhase.offline => (
        Icons.cloud_off,
        AppColors.warning,
        '${state.pending ?? 0} workout(s) waiting to upload',
      ),
      _ => (Icons.cloud_outlined, AppColors.textMuted, 'Ready to sync'),
    };
    final last = state.lastSyncedAt;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            if (last != null) ...[
              const SizedBox(height: AppSpacing.base),
              Text(
                'Last synced ${TimeOfDay.fromDateTime(last).format(context)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: AppSpacing.medium),
            Wrap(
              spacing: AppSpacing.small,
              runSpacing: AppSpacing.small,
              children: [
                OutlinedButton.icon(
                  key: const Key('sync_now'),
                  onPressed: state.phase == CloudSyncPhase.syncing
                      ? null
                      : onSyncNow,
                  icon: const Icon(Icons.sync, size: 18),
                  label: const Text('SYNC NOW'),
                ),
                OutlinedButton.icon(
                  key: const Key('sign_out'),
                  onPressed: onSignOut,
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('SIGN OUT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportView extends StatelessWidget {
  const _ReportView({
    required this.status,
    required this.report,
    required this.onDelete,
  });

  final SyncStatus status;
  final ProgressReport report;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Cloud progress report', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.base),
        Text(
          'Computed on the server from every synced workout.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.medium),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            StatTile(label: 'Workouts', value: '${status.workoutCount}'),
            StatTile(label: 'Sets', value: '${status.setCount}'),
            StatTile(label: 'Reps', value: '${status.totalReps}'),
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
            text: 'Finish a workout to see your first cloud report.',
          )
        else
          for (final exercise in report.exercises) ...[
            ExerciseProgressCard(progress: exercise),
            const SizedBox(height: AppSpacing.small),
          ],
        const SizedBox(height: AppSpacing.medium),
        TextButton.icon(
          key: const Key('delete_cloud'),
          onPressed: status.workoutCount == 0 ? null : onDelete,
          icon: const Icon(Icons.delete_outline, color: AppColors.degraded),
          label: const Text(
            'Delete cloud backup',
            style: TextStyle(color: AppColors.degraded),
          ),
        ),
      ],
    );
  }
}
