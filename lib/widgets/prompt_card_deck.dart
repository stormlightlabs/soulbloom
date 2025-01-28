import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/prompt_cards.dart';

class PromptCardDeck extends StatefulWidget {
  final String deckName;

  const PromptCardDeck({super.key, required this.deckName});

  @override
  State<PromptCardDeck> createState() => _PromptCardDeckState();
}

class _PromptCardDeckState extends State<PromptCardDeck> {
  late PromptCardDeckObject playingCardDeck;

  // TODO: Create an abstract Service class
  // TODO: Move to PromptCardDeckService
  Future<void> loadDeck() async {
    final String deckName = widget.deckName;
    final String content =
        await rootBundle.loadString("assets/data/$deckName.yml");
    final data = await jsonDecode(content) as PromptCardDeckObject;

    setState(() {
      playingCardDeck = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (playingCardDeck.cards.isEmpty) {
      return Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Title(
              color: Colors.white,
              child: Text(playingCardDeck.category),
            ),
            Expanded(
              child: Text("No cards in this deck"),
            )
          ],
        ),
      );
    } else {
      List<Widget> children = [
        Title(
          color: Colors.white,
          child: Text(playingCardDeck.category),
        )
      ];

      return ListView(
        children: children +
            playingCardDeck.cards
                .map<Widget>(
                  (card) => SizedBox(height: 50, child: Text(card.title)),
                )
                .toList(),
      );
    }
  }
}
