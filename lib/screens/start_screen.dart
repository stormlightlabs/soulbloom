// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../models/palette.dart';
import '../widgets/action_button.dart';
import 'responsive_screen.dart';
import 'settings/settings.dart';

/// Main Menu/Home Screen
///
/// This screen is the first screen the user sees when they open the app.
///
/// Options: Start, Settings, About, Github, Exit
class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/main-menu-bg.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ResponsiveScreen(
          squarishMainArea: Center(
            child: Text(
              'Soulbloom',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Jersey 25',
                fontSize: 55,
                height: 1,
                color: palette.trueWhite,
              ),
            ),
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(color: Colors.white),
                  )),
              _gap,
              ActionButton(
                onPressed: () => GoRouter.of(context).push('/settings'),
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settingsController.audioOn,
                  builder: (context, audioOn, child) {
                    return IconButton(
                      onPressed: () => settingsController.toggleAudioOn(),
                      icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                    );
                  },
                ),
              ),
              _gap,
              Text(
                'v0.1.0 by Stormlight Labs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey 25',
                  color: palette.trueWhite,
                ),
              ),
              _gap,
              Text(
                'Music by Mr Smith',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey 25',
                  color: palette.trueWhite,
                ),
              ),
              _gap,
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
