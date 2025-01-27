// Copyright 2025, Stormlight Labs

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'persistence/local_storage_settings_persistence.dart';
import 'persistence/settings_persistence.dart';

class SettingsController {
  static final _log = Logger('SettingsController');

  final SettingsPersistence _store;

  ValueNotifier<bool> audioOn = ValueNotifier(true);

  ValueNotifier<String> playerName = ValueNotifier('Player');

  ValueNotifier<bool> soundsOn = ValueNotifier(true);

  ValueNotifier<bool> musicOn = ValueNotifier(true);

  /// Creates a new instance of [SettingsController] backed by [store].
  ///
  /// By default, settings are persisted using [LocalStorageSettingsPersistence]
  /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
  /// local storage on the web).
  SettingsController({SettingsPersistence? store})
      : _store = store ?? LocalStorageSettingsPersistence() {
    _loadStateFromPersistence();
  }

  void setPlayerName(String name) {
    playerName.value = name;
    _store.savePlayerName(playerName.value);
  }

  void toggleAudioOn() {
    audioOn.value = !audioOn.value;
    _store.saveAudioOn(audioOn.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _store.saveMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _store.saveSoundsOn(soundsOn.value);
  }

  /// Asynchronously loads values from the injected persistence store.
  Future<void> _loadStateFromPersistence() async {
    final loadedValues = await Future.wait([
      _store.getAudioOn(defaultValue: true).then((value) {
        if (kIsWeb) {
          // On the web, sound can only start after user interaction, so
          // we start muted there on every game start.
          return audioOn.value = false;
        }

        // On other platforms, we can use the persisted value.
        return audioOn.value = value;
      }),
      _store
          .getSoundsOn(defaultValue: true)
          .then((value) => soundsOn.value = value),
      _store
          .getMusicOn(defaultValue: true)
          .then((value) => musicOn.value = value),
      _store.getPlayerName().then((value) => playerName.value = value),
    ]);

    _log.fine(() => 'Loaded settings: $loadedValues');
  }
}
