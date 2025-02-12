// Copyright 2025, Stormlight Labs

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:soulbloom/models/prompt_cards.dart';

import '../data/settings_base_persistence.dart';
import '../data/settings_shared_prefs_persistence.dart';

class SettingsController {
  static final _log = Logger('SettingsController');
  final BaseSettingsPersistence _store;

  ValueNotifier<String?> username = ValueNotifier(null);
  ValueNotifier<DeckType?> defaultDeck = ValueNotifier(null);
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
    // final loadedValues = await Future.wait([
    //   _store.getUsername(),
    //   _store.getDefaultDeck(),
    //   _store.getSoundOn(defaultValue: true),
    //   _store.getHapticsOn(defaultValue: true),
    //   _store.getMaxDuration(defaultValue: 0),
    //   _store.getTimezone(defaultValue: _getDeviceTimezone()),
    //   _store.getDifficulty(defaultValue: Difficulty.hard),
    // ]);

    username.value = await _store.getUsername() ?? '';
    defaultDeck.value = await _store.getDefaultDeck();
    soundOn.value = await _store.getSoundOn(defaultValue: true);
    hapticsOn.value = await _store.getHapticsOn(defaultValue: true);
    maxDuration.value = await _store.getMaxDuration(defaultValue: 0);
    timezone.value =
        await _store.getTimezone(defaultValue: _getDeviceTimezone());
    difficulty.value =
        await _store.getDifficulty(defaultValue: Difficulty.hard);

    String loadedValues = debugState;

    _log.fine(() => 'Loaded settings: \n$loadedValues');
  }

  String? getPlayerName() => username.value;
  DeckType? getDefaultDeck() => defaultDeck.value;
  bool getSoundOn() => soundOn.value;

  static String _getDeviceTimezone() => DateTime.now().timeZoneName;

  /// In debug mode, we want to be able to clear the settings.
  Future<void> reset() async {
    if (kDebugMode) {
      _log.info("clearing settings");

      await _store.resetSettings();

      // Reset state
      await _loadStateFromPersistence();

      username.value = await _store.getUsername() ?? '';
      defaultDeck.value = await _store.getDefaultDeck();
      soundOn.value = await _store.getSoundOn(defaultValue: true);
    }
  }

  /// Returns a string representation of the controller's state.
  String get debugState {
    return '''
    username: ${username.value}
    defaultDeck: ${defaultDeck.value}
    soundOn: ${soundOn.value}
    hapticsOn: ${hapticsOn.value}
    maxDuration: ${maxDuration.value}
    timezone: ${timezone.value}
    difficulty: ${difficulty.value}
    ''';
  }
}
