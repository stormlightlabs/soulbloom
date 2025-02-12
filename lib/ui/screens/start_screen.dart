// Copyright 2025, Stormlight Labs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soulbloom/models/prompt_cards.dart';
import 'package:url_launcher/link.dart';

import '../../audio/sounds.dart';
import '../../models/controllers/audio_controller.dart';
import '../../models/controllers/settings_controller.dart';
import '../widgets/action_button.dart';
import '../widgets/common.dart';
import 'responsive_screen.dart';

/// Main Menu/Home Screen
///
/// This screen is the first screen the user sees when they open the app.
///
/// Options: Start, Settings, About, Github, Exit
class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  static const _bgImage = AssetImage("assets/images/main-menu-bg.png");

  /// We want to redirect if the user does not have a name and/or
  /// default deck selected.
  bool _shouldRedirect(SettingsController settings) {
    String? playerName = settings.getPlayerName();
    DeckType? selectedDeck = settings.getDefaultDeck();

    if (playerName == null || playerName.isEmpty) {
      return true;
    }

    if (selectedDeck == null) {
      return true;
    }

    return false;
  }

  void move(BuildContext ctx, SettingsController settings) {
    bool shouldRedirect = _shouldRedirect(settings);

    if (shouldRedirect) {
      GoRouter.of(ctx).go('/onboarding');
    } else {
      GoRouter.of(ctx).go('/play');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = context.watch<SettingsController>();
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
                  move(context, settings);
                },
                child: Text('Start', style: theme.titleLarge),
              ),
              Common.gap(),
              ActionButton(
                onPressed: () => GoRouter.of(context).push('/settings'),
                child: Text('Settings', style: theme.titleLarge),
              ),
              Common.gap(),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settings.soundOn,
                  builder: (context, audioOn, child) => IconButton(
                    onPressed: () => settings.toggleSoundOn(),
                    icon: Icon(
                      audioOn ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                      shadows: [BoxShadow(blurRadius: 12, color: Colors.black)],
                    ),
                  ),
                ),
              ),
              Common.gap(),
              _resetButton(context, settings),
              Text(
                'v0.1.0 by Stormlight Labs',
                textAlign: TextAlign.center,
                style: theme.labelSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLink(
                    "Our website",
                    'https://stormlightlabs.org',
                    theme.labelSmall!.copyWith(
                      shadows: [
                        BoxShadow(blurRadius: 12, color: Colors.green[900]!),
                      ],
                    ),
                  ),
                  Text(' | ', style: theme.labelSmall),
                  _buildLink(
                    "Source code",
                    'https://github.com/stormlightlabs/soulbloom',
                    theme.labelSmall!,
                  ),
                ],
              ),
              Common.gap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLink(String text, String url, TextStyle style) {
    return Link(
      uri: Uri.parse(url),
      builder: (BuildContext context, FollowLink? followLink) {
        return TextButton(
          onPressed: followLink,
          child: Text(text, style: style),
        );
      },
    );
  }

  // This (particularly the ScaffoldMessenger) can be recomposed, such that
  // it exists as a reuseable widget.
  Widget _resetButton(BuildContext ctx, SettingsController settings) {
    if (kDebugMode) {
      final theme = Theme.of(ctx).textTheme;
      return Padding(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Colors.red),
            overlayColor: Colors.redAccent,
            backgroundColor: Colors.white,
            shadowColor: Colors.redAccent,
          ),
          onPressed: () async {
            var state = settings.debugState;
            debugPrint("Resetting settings from \n$state");
            await settings.reset();

            if (ctx.mounted) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Settings reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.greenAccent,
                        size: 24,
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            state = settings.debugState;

            debugPrint("Settings reset to \n$state");
          },
          child: Text(
            "Reset Settings",
            style: theme.labelMedium!.copyWith(color: Colors.red),
          ),
        ),
      );
    } else {
      return Common.gap();
    }
  }
}
