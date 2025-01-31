// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soulbloom/models/persistence/settings_persistence.dart';

import '../models/controllers/settings_controller.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_name_dialog.dart';
import 'responsive_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);
  static const _bgImage = AssetImage("assets/images/settings-bg.png");

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: _bgImage, fit: BoxFit.fitHeight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ResponsiveScreen(
          squarishMainArea: ListView(
            children: [
              _gap,
              const Text(
                'Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey 25',
                  fontSize: 55,
                  height: 1,
                  color: Colors.white,
                ),
              ),
              _gap,
              const _NameChangeLine(),
              _gap,
              const _DifficultyChangeLine(),
              ValueListenableBuilder<bool>(
                valueListenable: settings.soundOn,
                builder: (context, soundsOn, child) => _SettingsLine(
                  'Sound FX',
                  Icon(
                    soundsOn ? Icons.graphic_eq : Icons.volume_off,
                    color: soundsOn ? Colors.white : Colors.white60,
                  ),
                  onSelected: () => settings.toggleSoundOn(),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.hapticsOn,
                builder: (context, hapticsOn, child) => _SettingsLine(
                  'Haptics',
                  Icon(
                    hapticsOn ? Icons.vibration : Icons.volume_off_outlined,
                    color: hapticsOn ? Colors.white : Colors.white60,
                  ),
                  onSelected: () => settings.toggleHapticsOn(),
                ),
              ),
            ],
          ),
          rectangularMenuArea: ActionButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.chevron_left),
                Text('Back'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String titlecase(String text) {
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

class _DifficultyChangeLine extends StatelessWidget {
  const _DifficultyChangeLine();

  final defaultDifficulty = Difficulty.hard;

  void showDifficultyDialog(BuildContext context) {
    final settings = context.read<SettingsController>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Difficulty'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: Difficulty.values
                .map(
                  (difficulty) => RadioListTile<Difficulty>(
                    title: Text(
                      titlecase(difficulty.toString()),
                      style: const TextStyle(
                        fontFamily: 'Jersey 25',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    value: difficulty,
                    groupValue: settings.difficulty.value,
                    onChanged: (value) {
                      settings.setDifficulty(value!);
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showDifficultyDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Difficulty',
              style: const TextStyle(
                fontFamily: 'Jersey 25',
                fontSize: 30,
                color: Colors.white60,
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.difficulty,
              builder: (context, difficulty, child) => Text(
                difficulty.toString().split('.').last,
                style: const TextStyle(
                  fontFamily: 'Jersey 25',
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  const _NameChangeLine();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name',
              style: const TextStyle(
                fontFamily: 'Jersey 25',
                fontSize: 30,
                color: Colors.white60,
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.username,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: const TextStyle(
                  fontFamily: 'Jersey 25',
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Jersey 25',
                  fontSize: 30,
                  color: Colors.white60,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
