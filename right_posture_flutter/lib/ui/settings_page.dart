import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_controller.dart';
import 'account_page.dart';
import 'app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, this.showAccount = true});

  /// False when opened from the profile tab, which already is the account.
  final bool showAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Coaching settings')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.medium),
              children: [
                SwitchListTile(
                  key: const Key('tts_setting'),
                  title: const Text('Voice coaching'),
                  subtitle: const Text(
                    'Speak guided and checkpoint coaching. Requires internet.',
                  ),
                  value: preferences.ttsEnabled,
                  onChanged: controller.setTtsEnabled,
                ),
                SwitchListTile(
                  key: const Key('haptics_setting'),
                  title: const Text('Haptic coaching'),
                  subtitle: const Text('Vibrate once for each degraded rep.'),
                  value: preferences.hapticsEnabled,
                  onChanged: controller.setHapticsEnabled,
                ),
                SwitchListTile(
                  key: const Key('sound_setting'),
                  title: const Text('Sound cues'),
                  subtitle: const Text(
                    'Play one short sound for each degraded rep.',
                  ),
                  value: preferences.soundEnabled,
                  onChanged: controller.setSoundEnabled,
                ),
                if (showAccount)
                  ListTile(
                    key: const Key('account_setting'),
                    leading: const Icon(Icons.cloud_outlined),
                    title: const Text('Account & cloud backup'),
                    subtitle: const Text(
                      'Sync workout summaries and view your server progress '
                      'report.',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const AccountPage(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
