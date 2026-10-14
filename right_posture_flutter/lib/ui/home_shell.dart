import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../cloud_sync.dart';
import 'account_page.dart';
import 'analytics_page.dart';
import 'app_theme.dart';
import 'coach_page.dart';
import 'exercise_select_page.dart';

enum HomeTab { workout, progress, coach, profile }

/// Main navigation outside a live session: Workout, Progress, Coach and
/// Profile. The workout tab keeps its state; the others reload when opened so
/// they always show freshly synced data.
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  HomeTab _tab = HomeTab.workout;
  final _visits = {for (final tab in HomeTab.values) tab: 0};
  int _unreadNotes = 0;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_refreshBadge);
    ref.read(cloudSyncProvider).addListener(_syncChanged);
    _refreshBadge();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_refreshBadge);
    ref.read(cloudSyncProvider).removeListener(_syncChanged);
    super.dispose();
  }

  void _syncChanged() {
    // Restored workouts from other devices must show up in Progress.
    if (ref.read(cloudSyncProvider).value.phase == CloudSyncPhase.synced) {
      ref.invalidate(historyProvider);
    }
  }

  Future<void> _refreshBadge() async {
    if (!client.auth.isAuthenticated) {
      if (mounted) setState(() => _unreadNotes = 0);
      return;
    }
    try {
      final notes = await client.coach.notes();
      if (!mounted) return;
      setState(() => _unreadNotes = notes.where((n) => !n.read).length);
    } catch (_) {
      // Offline: keep the last known badge.
    }
  }

  void _select(HomeTab tab) {
    if (tab == HomeTab.progress) ref.invalidate(historyProvider);
    setState(() {
      if (tab != HomeTab.workout) _visits[tab] = _visits[tab]! + 1;
      _tab = tab;
    });
    if (tab != HomeTab.coach) unawaited(_refreshBadge());
  }

  Widget _page(HomeTab tab) {
    final key = ValueKey('${tab.name}_${_visits[tab]}');
    return switch (tab) {
      HomeTab.workout => ExerciseSelectPage(
        onOpenProfile: () => _select(HomeTab.profile),
      ),
      HomeTab.progress => AnalyticsPage(key: key),
      HomeTab.coach => CoachPage(
        key: key,
        onNotesRead: () {
          if (mounted) setState(() => _unreadNotes = 0);
        },
      ),
      HomeTab.profile => AccountPage(key: key),
    };
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _tab == HomeTab.workout,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _select(HomeTab.workout);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _tab.index,
          children: [
            for (final tab in HomeTab.values)
              // Build other tabs only once visited, so startup stays light.
              tab == _tab || tab == HomeTab.workout || _visits[tab]! > 0
                  ? _page(tab)
                  : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: _HomeNavigationBar(
          selected: _tab,
          unreadNotes: _unreadNotes,
          onSelected: _select,
        ),
      ),
    );
  }
}

class _HomeNavigationBar extends StatelessWidget {
  const _HomeNavigationBar({
    required this.selected,
    required this.unreadNotes,
    required this.onSelected,
  });

  final HomeTab selected;
  final int unreadNotes;
  final ValueChanged<HomeTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final coachIcon = unreadNotes > 0
        ? Badge(
            label: Text('$unreadNotes'),
            child: const Icon(Icons.sports_outlined),
          )
        : const Icon(Icons.sports_outlined);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          indicatorColor: AppColors.lime,
          indicatorShape: const StadiumBorder(),
          height: 72,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? AppColors.background
                  : AppColors.textMuted,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 12,
              letterSpacing: 0.4,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w800
                  : FontWeight.w600,
              color: states.contains(WidgetState.selected)
                  ? AppColors.lime
                  : AppColors.textMuted,
            ),
          ),
        ),
        child: NavigationBar(
          key: const Key('home_navigation'),
          selectedIndex: selected.index,
          onDestinationSelected: (index) => onSelected(HomeTab.values[index]),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Workout',
              tooltip: 'Choose an exercise',
            ),
            const NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Progress',
              tooltip: 'History and analytics',
            ),
            NavigationDestination(
              icon: coachIcon,
              selectedIcon: const Icon(Icons.sports),
              label: 'Coach',
              tooltip: unreadNotes > 0
                  ? '$unreadNotes new coach note(s)'
                  : 'Share with your coach',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
              tooltip: 'Account, cloud backup and settings',
            ),
          ],
        ),
      ),
    );
  }
}
