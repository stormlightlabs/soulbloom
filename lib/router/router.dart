// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulbloom/screens/browser/deck_browser_screen.dart';
import 'package:soulbloom/screens/browser/deck_selection_screen.dart';
import 'package:soulbloom/screens/journal/screen.dart';
import 'package:soulbloom/screens/play/screen.dart';

import '../screens/home_screen.dart';
import '../screens/settings/settings_screen.dart';
import 'shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorPlayKey = GlobalKey<NavigatorState>(debugLabel: 'play');
final _shellNavigatorBrowserKey = GlobalKey<NavigatorState>(
  debugLabel: 'browser',
);
final _shellNavigatorJournalKey = GlobalKey<NavigatorState>(
  debugLabel: 'journal',
);

/// Application Routing Configuration
///
/// /: GardenScreen
/// /garden: CustomizeGardenScreen
/// /garden/growth: GardenGrowthScreen (user growth)
/// /garden/progress: GardenProgressScreen
/// /garden/achievements: GardenAchievementsScreen
///
/// /play: PlaySessionScreen (the game itself)
/// /play/draw: DrawCardScreen
///
/// /cards: CardsScreen
/// /cards/:id/: CardDetailScreen
/// /cards/saved: SavedCardsScreen
/// /cards/history: CardHistoryScreen
///
/// /journal: JournalScreen
/// /journal/new: NewJournalEntryScreen
/// /journal/:id/: JournalEntryScreen
/// /journal/:id/edit: EditJournalEntryScreen
///
/// /practice: PracticeScreen
/// /practice/meditation: MeditationScreen
/// /practice/breathwork: BreathworkScreen
/// /practice/guided: GuidedPracticeScreen
/// /practice/history: PracticeHistoryScreen
///
/// /settings: SettingsScreen
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navShell) {
            return SoulbloomShell(navigationShell: navShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorPlayKey,
              routes: [
                GoRoute(
                  path: '/play',
                  pageBuilder: (context, state) => const MaterialPage(
                    child: PlayScreen(),
                  ),
                  routes: [],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBrowserKey,
              routes: [
                GoRoute(
                  path: '/decks',
                  pageBuilder: (context, state) => const MaterialPage(
                    child: DeckSelectionScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: "/:id",
                      builder: (context, state) {
                        final String id = state.pathParameters["id"] as String;
                        return DeckBrowserScreen(id: id);
                      },
                    )
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorJournalKey,
              routes: [
                GoRoute(
                  path: "/journal",
                  pageBuilder: (context, state) {
                    return const MaterialPage(
                      child: JournalScreen(),
                    );
                  },
                )
              ],
            )
          ],
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) =>
              const SettingsScreen(key: Key('settings')),
        ),
      ],
    ),
  ],
);
