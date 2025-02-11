// Copyright 2025, Stormlight Labs

import '../prompt_cards.dart';

enum PrefKeys {
  playerName,
  defaultDeck,
  difficulty,
  maxDuration,
  timezone,
  soundOn,
  hapticsOn;

  @override
  String toString() {
    switch (this) {
      case playerName:
        return 'player_name';
      case defaultDeck:
        return 'default_deck';
      case difficulty:
        return 'difficulty';
      case maxDuration:
        return 'max_duration';
      case timezone:
        return 'timezone';
      case soundOn:
        return 'sound_on';
      case hapticsOn:
        return 'haptics_on';
    }
  }

  String get key => toString();
}

/// Therapy Modalities
enum Modality {
  art,
  act,
  dbt,
  cbt;

  static Modality fromString(String value) {
    switch (value) {
      case 'art':
        return Modality.art;
      case 'act':
        return Modality.act;
      case 'dbt':
        return Modality.dbt;
      case 'cbt':
      default:
        return Modality.cbt;
    }
  }
}

/// Activity Difficulty Levels
enum Difficulty {
  easy,
  medium,
  hard;

  static Difficulty fromString(String value) {
    switch (value) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'hard':
      default:
        return Difficulty.hard;
    }
  }
}

/// Export Options
enum ExportOptions {
  none,
  email,
  csv,
  cloudDropbox,
  cloudGoogleDrive,
  cloudOneDrive,
  cloudICloud,
}

/// An interface of persistence stores for settings.
///
/// Initial Version
///   - Difficulty Level (default is Hard for all cards)
///   - Max Duration of Card (0 for no limit)
///   - User Name
///   - Timezone (default to device timezone)
///   - sounds On
///   - haptics On
///
/// - Default Deck
abstract class BaseSettingsPersistence {
  Future<void> setDifficulty(Difficulty difficulty);
  Future<void> setMaxDuration(int duration);
  Future<void> setUsername(String name);
  Future<void> setTimezone(String timezone);
  Future<void> setHapticsOn(bool hapticsOn);
  Future<void> setSoundOn({required bool soundOn});
  Future<void> setDefaultDeck(DeckType? deckType);

  Future<Difficulty> getDifficulty({required Difficulty defaultValue});
  Future<int> getMaxDuration({required int defaultValue});
  Future<String> getTimezone({required String defaultValue});
  Future<bool> getHapticsOn({required bool defaultValue});
  Future<bool> getSoundOn({required bool defaultValue});

  /// Nullable because on first run, this is set by the user.
  Future<String?> getUsername({String defaultValue});

  /// This is nullable because we want to launch the "onboarding" screen so
  /// that the user can select a default deck.
  Future<DeckType?> getDefaultDeck();
}
