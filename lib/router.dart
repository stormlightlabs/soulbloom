// Copyright 2025, Stormlight Labs

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:soulbloom/screens/play/screen.dart';

import 'screens/home_screen.dart';
import 'screens/settings/settings_screen.dart';

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
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
          path: "play",
          builder: (context, state) => const PlayScreen(
            key: Key("play"),
          ),
          routes: [],
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
