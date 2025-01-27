// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../style/action_button.dart';
import '../../style/responsive_screen.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/settings-bg.png"),
          fit: BoxFit.fitHeight,
        ),
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
              const _NameChangeLine(
                'Name',
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.soundsOn,
                builder: (context, soundsOn, child) => _SettingsLine(
                  'Sound FX',
                  Icon(
                    soundsOn ? Icons.graphic_eq : Icons.volume_off,
                    color: soundsOn ? Colors.white : Colors.white60,
                  ),
                  onSelected: () => settings.toggleSoundsOn(),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.musicOn,
                builder: (context, musicOn, child) => _SettingsLine(
                  'Music',
                  Icon(
                    musicOn ? Icons.music_note : Icons.music_off,
                    color: musicOn ? Colors.white : Colors.white60,
                  ),
                  onSelected: () => settings.toggleMusicOn(),
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

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

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
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Jersey 25',
                  fontSize: 30,
                  color: Colors.white60,
                )),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
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
