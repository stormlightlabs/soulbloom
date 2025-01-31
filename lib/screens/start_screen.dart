// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import '../audio/sounds.dart';
import '../models/controllers/audio_controller.dart';
import '../models/controllers/settings_controller.dart';
import '../widgets/action_button.dart';
import 'responsive_screen.dart';

/// Main Menu/Home Screen
///
/// This screen is the first screen the user sees when they open the app.
///
/// Options: Start, Settings, About, Github, Exit
class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  static const _bgImage = AssetImage("assets/images/main-menu-bg.png");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: _bgImage, fit: BoxFit.fitHeight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ResponsiveScreen(
          squarishMainArea: Center(
            child: Text(
              'Soulbloom',
              textAlign: TextAlign.center,
              style: theme.displayLarge,
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
                child: Text('Start', style: theme.titleLarge),
              ),
              _gap,
              ActionButton(
                onPressed: () => GoRouter.of(context).push('/settings'),
                child: Text('Settings', style: theme.titleLarge),
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settingsController.soundOn,
                  builder: (context, audioOn, child) => IconButton(
                    onPressed: () => settingsController.toggleSoundOn(),
                    icon: Icon(
                      audioOn ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                      shadows: [BoxShadow(blurRadius: 12, color: Colors.black)],
                    ),
                  ),
                ),
              ),
              _gap,
              _gap,
              Text(
                'v0.1.0 by Stormlight Labs',
                textAlign: TextAlign.center,
                style: theme.labelSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Link(
                    uri: Uri.parse('https://stormlightlabs.org'),
                    builder: (BuildContext context, FollowLink? followLink) {
                      return TextButton(
                        onPressed: followLink,
                        child: Text(
                          "Our website",
                          style: theme.labelSmall!.copyWith(
                            shadows: [
                              BoxShadow(
                                  blurRadius: 12, color: Colors.green[900]!),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Text(' | ', style: theme.labelSmall),
                  Link(
                    uri: Uri.parse(
                        'https://github.com/stormlightlabs/soulbloom'),
                    builder: (BuildContext context, FollowLink? followLink) {
                      return TextButton(
                        onPressed: followLink,
                        child: Text("Source code", style: theme.labelSmall),
                      );
                    },
                  ),
                ],
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
