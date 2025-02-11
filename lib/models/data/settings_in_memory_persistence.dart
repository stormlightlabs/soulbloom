// Copyright 2025, Stormlight Labs

import 'package:soulbloom/models/prompt_cards.dart';

import 'settings_base_persistence.dart';

/// Useful for testing.
class InMemSettingsPersistence extends BaseSettingsPersistence {
  String? _username;
  Difficulty? _difficulty;
  DeckType? _deckType;
  int? _maxDuration;
  String? _timezone;
  bool _hapticsOn = false;
  bool _soundOn = true;

  @override
  Future<String?> getUsername({String? defaultValue}) async =>
      _username ?? defaultValue;

  @override
  Future<DeckType?> getDefaultDeck() async => _deckType;

  @override
  Future<Difficulty> getDifficulty({required Difficulty defaultValue}) async {
    return _difficulty ?? defaultValue;
  }

  @override
  Future<int> getMaxDuration({required int defaultValue}) async {
    return _maxDuration ?? defaultValue;
  }

  @override
  Future<String> getTimezone({required String defaultValue}) async {
    return _timezone ?? defaultValue;
  }

  @override
  Future<void> setUsername(String name) async {
    _username = name;
  }

  @override
  Future<void> setDifficulty(Difficulty difficulty) async {
    _difficulty = difficulty;
  }

  @override
  Future<void> setMaxDuration(int duration) async {
    _maxDuration = duration;
  }

  @override
  Future<void> setTimezone(String timezone) async {
    _timezone = timezone;
  }

  @override
  Future<void> setHapticsOn(bool hapticsOn) async {
    _hapticsOn = hapticsOn;
  }

  @override
  Future<bool> getHapticsOn({required bool defaultValue}) async => _hapticsOn;

  @override
  Future<void> setSoundOn({required bool soundOn}) async {
    _soundOn = soundOn;
  }

  @override
  Future<bool> getSoundOn({required bool defaultValue}) async => _soundOn;

  @override
  Future<void> setDefaultDeck(DeckType? deckType) async {
    _deckType = deckType ?? DeckType.rest;
  }
}
