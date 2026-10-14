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

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.onContinueOffline});

  final VoidCallback? onContinueOffline;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final EmailAuthController _email = EmailAuthController(
    client: client,
    startScreen: EmailFlowScreen.startRegistration,
    onError: _showError,
  );

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _showError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sign-in failed: $error')));
  }

  bool get _awaitingCode => switch (_email.currentScreen) {
    EmailFlowScreen.verifyRegistration ||
    EmailFlowScreen.verifyPasswordReset => true,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onContinueOffline = widget.onContinueOffline;
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
                  ListenableBuilder(
                    listenable: _email,
                    builder: (context, _) => _awaitingCode
                        ? const _CheckSpamBanner()
                        : const SizedBox.shrink(),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      child: SignInWidget(
                        client: client,
                        emailSignInWidget: EmailSignInWidget(
                          controller: _email,
                        ),
                        onError: _showError,
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

class _CheckSpamBanner extends StatelessWidget {
  const _CheckSpamBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('check_spam_hint'),
      margin: const EdgeInsets.only(bottom: AppSpacing.medium),
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.mark_email_unread_outlined,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.small),
          Expanded(
            child: Text(
              'We emailed you a verification code. It can take a minute. '
              "If you don't see it, check your Spam, Junk or Promotions "
              'folder.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pushed sign-in screen that closes itself once the user is signed in.
class SignInRoute extends StatefulWidget {
  const SignInRoute({super.key});

  @override
  State<SignInRoute> createState() => SignInRouteState();
}

class SignInRouteState extends State<SignInRoute> {
  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_maybeClose);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_maybeClose);
    super.dispose();
  }

  void _maybeClose() {
    if (client.auth.isAuthenticated && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => const SignInPage();
}

/// Prompt shown on account-only screens while signed out.
class SignedOutCard extends StatelessWidget {
  const SignedOutCard({super.key, required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Training offline',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Workouts are saved on this phone only. Sign in to back them '
              'up and get a server-computed progress report.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.medium),
            FilledButton(
              key: const Key('account_sign_in'),
              onPressed: onSignIn,
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
