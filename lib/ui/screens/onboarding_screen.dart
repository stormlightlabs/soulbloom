// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:soulbloom/models/controllers/settings_controller.dart';
import 'package:soulbloom/models/prompt_cards.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

/// [OnboardingScreenState] is the state for [OnboardingScreen],
/// containing a player name text field and default deck selector.
class OnboardingScreenState extends State<OnboardingScreen> {
  String playerName = "";
  DeckType? selectedDeck;

  Logger log = Logger('OnboardingScreenState');

  /// Label, value pairs for the deck dropdown.
  List<DropdownMenuItem<DeckType>> get dropDownItems => DeckType.list
      .map((deckType) => DropdownMenuItem<DeckType>(
            value: deckType,
            child: Text(deckType.name),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100]!,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_title, _input, _dropdown, _submit(settings), _clear],
      ),
    );
  }

  Widget get _title => const Text(
        'Welcome to Soulbloom!',
        style: TextStyle(color: Colors.black87),
      );

  Widget get _input => Padding(
        padding: EdgeInsets.all(24),
        child: TextField(
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter your name',
          ),
          onChanged: (value) => setState(() => playerName = value),
        ),
      );

  Widget get _dropdown => DropdownButton<DeckType>(
        items: dropDownItems,
        hint: Text('Select a deck'),
        value: selectedDeck,
        onChanged: (item) => setState(() => selectedDeck = item),
      );

  Widget get _clear {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: OutlinedButton(
        onPressed: () => setState(() {
          playerName = '';
          selectedDeck = null;
        }),
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: const BorderSide(color: Colors.white),
          backgroundColor: Colors.redAccent,
          textStyle: const TextStyle(color: Colors.white),
        ),
        child: const Text('Clear'),
      ),
    );
  }

  Widget _submit(SettingsController settings) {
    return ElevatedButton(
      onPressed: () {
        log.info('Starting game with $playerName and $selectedDeck');

        settings.saveUsername(playerName.isEmpty ? playerName : 'Player');
        settings.setDefaultDeck(selectedDeck ?? DeckType.rest);

        if (context.mounted) GoRouter.of(context).go('/play');
      },
      child: const Text('Start'),
    );
  }
}
