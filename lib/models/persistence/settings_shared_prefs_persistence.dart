// Copyright 2025, Stormlight Labs

import "package:shared_preferences/shared_preferences.dart";

import './settings_persistence.dart';

class SharedPrefsSettingsPersistence extends BaseSettingsPersistence {
  final Future<SharedPreferences> store = SharedPreferences.getInstance();

  @override
  Future<String> getUsername({required String defaultValue}) async {
    final prefs = await store;
    return prefs.getString('username') ?? defaultValue;
  }

  @override
  Future<Difficulty> getDifficulty({required Difficulty defaultValue}) async {
    final prefs = await store;
    final difficulty = prefs.getString('difficulty');

    if (difficulty == null) {
      return defaultValue;
    } else {
      return Difficulty.fromString(difficulty);
    }
  }

  @override
  Future<int> getMaxDuration({required int defaultValue}) async {
    final prefs = await store;
    return prefs.getInt('max_duration') ?? defaultValue;
  }

  @override
  Future<String> getTimezone({required String defaultValue}) async {
    final prefs = await store;
    return prefs.getString('timezone') ?? defaultValue;
  }

  @override
  Future<void> setUsername(String name) async {
    final prefs = await store;
    await prefs.setString('username', name);
  }

  @override
  Future<void> setDifficulty(Difficulty difficulty) async {
    final prefs = await store;
    await prefs.setString('difficulty', difficulty.toString());
  }

  @override
  Future<void> setMaxDuration(int duration) async {
    final prefs = await store;
    await prefs.setInt('max_duration', duration);
  }

  @override
  Future<void> setTimezone(String timezone) async {
    final prefs = await store;
    await prefs.setString('timezone', timezone);
  }

  @override
  Future<void> setSoundOn({required bool soundOn}) async {
    final prefs = await store;
    await prefs.setBool('sound_on', soundOn);
  }

  @override
  Future<bool> getSoundOn({required bool defaultValue}) async {
    final prefs = await store;
    return prefs.getBool('sound_on') ?? defaultValue;
  }

  @override
  Future<void> setHapticsOn(bool hapticsOn) async {
    final prefs = await store;
    await prefs.setBool('haptics_on', hapticsOn);
  }

  @override
  Future<bool> getHapticsOn({required bool defaultValue}) async {
    final prefs = await store;
    return prefs.getBool('haptics_on') ?? defaultValue;
  }
}
