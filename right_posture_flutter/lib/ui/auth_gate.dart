import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client.dart';
import '../cloud_sync.dart';
import 'app_theme.dart';

/// Shows sign-in until the user has an account session or chose to train
/// offline, then shows [child]. Signing in starts a cloud sync.
class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key, required this.child});

  static const offlineKey = 'auth.offline.v1';

  final Widget child;

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  final _preferences = SharedPreferencesAsync();
  bool _signedIn = client.auth.isAuthenticated;
  bool? _offline;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_authChanged);
    unawaited(_loadOffline());
    if (_signedIn) unawaited(ref.read(cloudSyncProvider).sync());
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_authChanged);
    super.dispose();
  }

  Future<void> _loadOffline() async {
    bool offline;
    try {
      offline = await _preferences.getBool(AuthGate.offlineKey) ?? false;
    } catch (_) {
      offline = false;
    }
    if (mounted) setState(() => _offline = offline);
  }

  void _authChanged() {
    final signedIn = client.auth.isAuthenticated;
    if (signedIn == _signedIn) return;
    setState(() => _signedIn = signedIn);
    final cloud = ref.read(cloudSyncProvider);
    if (signedIn) {
      unawaited(_preferences.setBool(AuthGate.offlineKey, false));
      unawaited(cloud.reset().then((_) => cloud.sync()));
    } else {
      unawaited(cloud.reset());
    }
  }

  Future<void> _continueOffline() async {
    try {
      await _preferences.setBool(AuthGate.offlineKey, true);
    } catch (_) {}
    if (mounted) setState(() => _offline = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_signedIn || _offline == true) return widget.child;
    if (_offline == null) {
      return const Scaffold(body: SizedBox.shrink());
    }
    return SignInPage(onContinueOffline: _continueOffline);
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, this.onContinueOffline});

  final VoidCallback? onContinueOffline;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.accessibility_new,
                    color: AppColors.lime,
                    size: 48,
                    semanticLabel: 'Right Posture',
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(
                    'Right Posture',
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Sign in to back up your workout summaries and see '
                    'progress across devices. Camera frames and pose data '
                    'never leave your phone.',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      child: SignInWidget(
                        client: client,
                        onError: (error) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign-in failed: $error')),
                            ),
                      ),
                    ),
                  ),
                  if (onContinueOffline != null) ...[
                    const SizedBox(height: AppSpacing.medium),
                    TextButton(
                      key: const Key('continue_offline'),
                      onPressed: onContinueOffline,
                      child: const Text('Use offline only (no sync)'),
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
