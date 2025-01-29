// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';

import '../../models/prompt_cards.dart';
import '../../models/prompt_decks.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  PromptCardDeckObject get currentDeck => promptDecks[0];
  String get currentDeckName => promptDecks[0].name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Title(color: Colors.white, child: Text("Good morning, ")),
            Title(color: Colors.white, child: Text("Player")),
          ],
        ),
        _buildCurrentDeckRow(),
        _gap,
        Center(
          child: Stack(
            children: [
              Card(
                color: Colors.transparent,
                margin: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => {debugPrint("tapped card")},
                  splashColor: Colors.blueGrey,
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Text("card"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _gap,
        Container(
          padding: EdgeInsets.all(24.0),
          child: Text(currentDeck.description),
        )
      ],
    );
  }

  static const _gap = SizedBox(height: 10);

  Widget _buildCurrentDeckRow() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Current Deck: "),
          Text(currentDeckName, style: TextStyle(fontStyle: FontStyle.italic))
        ],
      ),
    );
  }
}
