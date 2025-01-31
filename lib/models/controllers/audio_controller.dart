// Copyright 2025, Stormlight Labs

import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../../audio/sounds.dart';
import '../app_lifecycle.dart';
import 'settings_controller.dart';

/// A wrapper around `package:audioplayers` that allows playing music and sound.
class AudioController {
  /// This is a list of [AudioPlayer] instances which
  /// are rotated to play sound effects.
  final List<AudioPlayer> _sfxPlayers;
  final Random _random = Random();

  int _currentSfxPlayer = 0;

  SettingsController? _settings;

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  static final _log = Logger('AudioController');

  /// Creates an instance that plays music and sound.
  ///
  /// Use [polyphony] to configure the number of sound effects (SFX) that can
  /// play at the same time. A [polyphony] of `1` will always only play one
  /// sound (a new sound will stop the previous one). See discussion
  /// of [_sfxPlayers] to learn why this is the case.
  ///
  /// Background music does not count into the [polyphony] limit. Music will
  /// never be overridden by sound effects because that would be silly.
  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _sfxPlayers = Iterable.generate(
                polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
            .toList(growable: false) {
    unawaited(_preloadSfx());
  }

  /// Makes sure the audio controller is listening to changes
  /// of both the app lifecycle (e.g. suspended app) and to
  /// changes of settings (e.g. muted sound).
  void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
      SettingsController settingsController) {
    _attachLifecycleNotifier(lifecycleNotifier);
    _attachSettings(settingsController);
  }

  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  /// Plays a single sound effect, defined by [type].
  ///
  /// The controller will ignore this call when the attached settings'
  /// [SettingsController.audioOn] is `true` or if its
  /// [SettingsController.soundsOn] is `false`.
  void playSfx(SfxType type) {
    final soundsOn = _settings?.soundOn.value ?? false;
    if (!soundsOn) {
      _log.fine(() =>
          'Ignoring playing sound ($type) because sounds are turned off.');
      return;
    }

    _log.fine(() => 'Playing sound: $type');
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _log.fine(() => '- Chosen filename: $filename');

    final currentPlayer = _sfxPlayers[_currentSfxPlayer];
    currentPlayer.play(AssetSource('sfx/$filename'),
        volume: soundTypeToVolume(type));
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  /// Enables the [AudioController] to listen to [AppLifecycleState] events,
  /// and therefore do things like stopping playback when the game
  /// goes into the background.
  void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }

  /// Enables the [AudioController] to track changes to settings.
  /// Namely, when [SettingsController.soundOn] changes,
  /// the audio controller will act accordingly.
  void _attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) {
      // Already attached to this instance. Nothing to do.
      return;
    }

    // Remove handlers from the old settings controller if present
    final oldSettings = _settings;
    if (oldSettings != null) {
      oldSettings.soundOn.removeListener(_soundsOnHandler);
    }

    _settings = settingsController;

    settingsController.soundOn.addListener(_soundsOnHandler);

    if (settingsController.soundOn.value) {
      if (kIsWeb) {
        _log.info('On the web, music can only start after user interaction.');
      }
    }
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _stopAllSound();
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        // No need to react to this state change.
        break;
    }
  }

  /// Preloads all sound effects.
  /// This assumes there is only a limited number of sound effects in the game.
  /// If there are hundreds of long sound effect files, it's better
  /// to be more selective when preloading.
  Future<void> _preloadSfx() async {
    _log.info('Preloading sound effects');
    await AudioCache.instance.loadAll(SfxType.values
        .expand(soundTypeToFilename)
        .map((path) => 'sfx/$path')
        .toList());
  }

  void _soundsOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.playing) {
        player.stop();
      }
    }
  }

  void _stopAllSound() {
    _log.info('Stopping sound');
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }
}
