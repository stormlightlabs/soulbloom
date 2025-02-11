// Copyright 2025, Stormlight Labs

import "package:shared_preferences/shared_preferences.dart";
import 'package:soulbloom/models/prompt_cards.dart';

import 'settings_base_persistence.dart';

class SharedPrefsSettingsPersistence extends BaseSettingsPersistence {
  final Future<SharedPreferences> store = SharedPreferences.getInstance();

  @override
  Future<String?> getUsername({String? defaultValue}) async {
    final prefs = await store;
    return prefs.getString(PrefKeys.playerName.key);
  }

  @override
  Future<void> setUsername(String? name) async {
    final prefs = await store;
    await prefs.setString(PrefKeys.playerName.key, name ?? 'Player');
  }

  @override
  Future<DeckType?> getDefaultDeck() async {
    final prefs = await store;
    final defaultDeckType = prefs.getString(PrefKeys.defaultDeck.key);

    if (defaultDeckType == null) {
      return null;
    } else {
      return DeckType.reverse(defaultDeckType);
    }
  }

  @override
  Future<void> setDefaultDeck(DeckType? deckType) async {
    final prefs = await store;
    final type = deckType?.toString() ?? DeckType.rest.toString();
    await prefs.setString(PrefKeys.defaultDeck.key, type);
  }

  @override
  Future<Difficulty> getDifficulty({required Difficulty defaultValue}) async {
    final prefs = await store;
    final difficulty = prefs.getString(PrefKeys.difficulty.key);

    if (difficulty == null) {
      return defaultValue;
    } else {
      return Difficulty.fromString(difficulty);
    }
  }

  @override
  Future<void> setDifficulty(Difficulty difficulty) async {
    final prefs = await store;
    await prefs.setString(PrefKeys.difficulty.key, difficulty.toString());
  }

  @override
  Future<int> getMaxDuration({required int defaultValue}) async {
    final prefs = await store;
    return prefs.getInt(PrefKeys.maxDuration.key) ?? defaultValue;
  }

  @override
  Future<void> setMaxDuration(int duration) async {
    final prefs = await store;
    await prefs.setInt(PrefKeys.maxDuration.key, duration);
  }

  @override
  Future<String> getTimezone({required String defaultValue}) async {
    final prefs = await store;
    return prefs.getString(PrefKeys.timezone.key) ?? defaultValue;
  }

  @override
  Future<void> setTimezone(String timezone) async {
    final prefs = await store;
    await prefs.setString(PrefKeys.timezone.key, timezone);
  }

  @override
  Future<void> setSoundOn({required bool soundOn}) async {
    final prefs = await store;
    await prefs.setBool(PrefKeys.soundOn.key, soundOn);
  }

  @override
  Future<bool> getSoundOn({required bool defaultValue}) async {
    final prefs = await store;
    return prefs.getBool(PrefKeys.soundOn.key) ?? defaultValue;
  }

  @override
  Future<void> setHapticsOn(bool hapticsOn) async {
    final prefs = await store;
    await prefs.setBool(PrefKeys.hapticsOn.key, hapticsOn);
  }

  @override
  Future<bool> getHapticsOn({required bool defaultValue}) async {
    final prefs = await store;
    return prefs.getBool(PrefKeys.hapticsOn.key) ?? defaultValue;
  }
}
