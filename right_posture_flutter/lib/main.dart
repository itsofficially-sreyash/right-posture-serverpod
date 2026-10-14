import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client.dart';
import 'cloud_sync.dart';
import 'demo_seed.dart';
import 'history_storage.dart';
import 'settings_controller.dart';
import 'ui/app_theme.dart';
import 'ui/auth_gate.dart';
import 'ui/session_flow.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  final storage = SharedPreferencesSettingsStorage(SharedPreferencesAsync());
  CoachingPreferences preferences;
  try {
    preferences = await storage.load();
  } catch (_) {
    preferences = const CoachingPreferences();
  }
  late final CloudSync cloud;
  final history = SyncingHistoryStorage(
    SharedPreferencesHistoryBackend(),
    cloud: () => cloud,
  );
  cloud = CloudSync(local: history, api: ServerpodCloudApi(client));
  if (demoSeedEnabled) await seedDemoHistory(history);
  runApp(
    ProviderScope(
      overrides: [
        historyStorageProvider.overrideWithValue(history),
        cloudSyncProvider.overrideWithValue(cloud),
        settingsStorageProvider.overrideWithValue(storage),
        initialCoachingPreferencesProvider.overrideWithValue(preferences),
      ],
      child: const RightPostureApp(),
    ),
  );
}

class RightPostureApp extends StatelessWidget {
  const RightPostureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const AuthGate(child: SessionFlow()),
    );
  }
}
