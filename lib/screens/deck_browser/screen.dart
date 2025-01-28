// Copyright 2025, Stormlight Labs

import 'package:flutter/widgets.dart';
import 'package:soulbloom/widgets/prompt_card_deck.dart';

class DeckBrowser extends StatefulWidget {
  const DeckBrowser({super.key});

  @override
  State<DeckBrowser> createState() => _DeckBrowserState();
}

class _DeckBrowserState extends State<DeckBrowser> {
  List<PromptCardDeck> promptCardDecks = [];

  // TODO: Implement this to read the assets/data directory
  //  then create a list of PromptCardDeck objects.
  // TODO: Handle persistence of custom cards
  // TODO: Move to PromptCardDeckService
  Future<void> readDataDir() async {
    setState(() {
      promptCardDecks = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}
