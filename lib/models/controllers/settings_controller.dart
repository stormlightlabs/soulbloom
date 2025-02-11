// Copyright 2025, Stormlight Labs

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:soulbloom/models/prompt_cards.dart';

import '../persistence/settings_base_persistence.dart';
import '../persistence/settings_shared_prefs_persistence.dart';

class SettingsController {
  static final _log = Logger('SettingsController');
  final BaseSettingsPersistence _store;

  ValueNotifier<String> username = ValueNotifier('Player');
  ValueNotifier<DeckType> defaultDeck = ValueNotifier(DeckType.rest);
  ValueNotifier<bool> soundOn = ValueNotifier(true);
  ValueNotifier<bool> hapticsOn = ValueNotifier(true);
  ValueNotifier<int> maxDuration = ValueNotifier(0);
  ValueNotifier<String> timezone = ValueNotifier(_getDeviceTimezone());
  ValueNotifier<Difficulty> difficulty = ValueNotifier(Difficulty.hard);

  /// Creates a new instance of [SettingsController] backed by [store].
  ///
  /// By default, settings are persisted using [SharedPrefsSettingsPersistence]
  /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
  /// local storage on the web).
  SettingsController({BaseSettingsPersistence? store})
      : _store = store ?? SharedPrefsSettingsPersistence() {
    _loadStateFromPersistence();
  }

  void saveUsername(String name) {
    username.value = name;
    _store.setUsername(name);
  }

  void toggleSoundOn() {
    soundOn.value = !soundOn.value;
    _store.setSoundOn(soundOn: soundOn.value);
  }

  void toggleHapticsOn() {
    hapticsOn.value = !hapticsOn.value;
    _store.setHapticsOn(hapticsOn.value);
  }

  void setMaxDuration(int duration) {
    maxDuration.value = duration;
    _store.setMaxDuration(duration);
  }

  void setTimezone(String tz) {
    timezone.value = tz;
    _store.setTimezone(tz);
  }

  void setDifficulty(Difficulty diff) {
    difficulty.value = diff;
    _store.setDifficulty(diff);
  }

  void setDefaultDeck(DeckType? deckType) {
    defaultDeck.value = deckType ?? DeckType.rest;
    _store.setDefaultDeck(deckType);
  }

  /// Asynchronously loads values from the injected persistence store.
  Future<void> _loadStateFromPersistence() async {
    final loadedValues = await Future.wait([
      _store.getUsername(defaultValue: 'Player'),
      _store.getSoundOn(defaultValue: true),
      _store.getHapticsOn(defaultValue: true),
      _store.getMaxDuration(defaultValue: 0),
      _store.getTimezone(defaultValue: _getDeviceTimezone()),
      _store.getDifficulty(defaultValue: Difficulty.hard),
    ]);

    _log.fine(() => 'Loaded settings: $loadedValues');
  }

  String? getPlayerName() => username.value;
  DeckType? getDefaultDeck() => defaultDeck.value;
  bool getSoundOn() => soundOn.value;

  static String _getDeviceTimezone() => DateTime.now().timeZoneName;
}
