// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/prompt_cards.dart';
import '../models/prompt_deck_provider.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(decksProvider);
    final type = DeckType.random();
    final theme = Theme.of(context).textTheme;
    return decksAsync.when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (decks) {
        final PromptCardDeckObject deck = decks.getDeck(type);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Shuffle and Draw",
              style: theme.bodyLarge!.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(child: _buildScreenLayout(deck)),
        );
      },
    );
  }

  Widget get _gap => SizedBox(height: 10);

  Widget _buildScreenLayout(PromptCardDeckObject currentDeck) {
    final currentCard = currentDeck.shuffleAndDraw();
    final bgColor = DeckType.getDeckBgColor(currentDeck.name);
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
        _buildCurrentDeckRow(currentDeck),
        _gap,
        Center(
          child: Stack(children: [_buildInteractiveCard(currentCard, bgColor)]),
        ),
        _gap,
        Container(
          padding: EdgeInsets.all(24.0),
          child: Text(currentDeck.description),
        )
      ],
    );
  }

  Widget _buildInteractiveCard(PromptCardObject card, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.all(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => {debugPrint("tapped card")},
          splashColor: Colors.blueGrey,
          child: Container(
            margin: EdgeInsets.all(16),
            width: 300,
            child: Column(
              children: [
                Text(card.title, style: TextStyle(fontSize: 24)),
                Center(
                  child: Text(
                    card.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _buildCardFooter(card),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFooter(PromptCardObject card) {
    final style = TextStyle(
        fontSize: 12,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        fontWeight: FontWeight.bold,
        shadows: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ]);
    final duration = card.duration.toString();
    final difficulty = titleCase(card.difficulty);
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Duration: $duration minutes", style: style),
          Text(" | ", style: style),
          Text("Difficulty: $difficulty", style: style),
        ],
      ),
    );
  }

  String titleCase(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Widget _buildCurrentDeckRow(PromptCardDeckObject currentDeck) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Current Deck: "),
          Text(currentDeck.name, style: TextStyle(fontStyle: FontStyle.italic))
        ],
      ),
    );
  }
}
