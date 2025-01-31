// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulbloom/screens/settings_screen.dart';

import '../models/prompt_cards.dart';
import '../models/prompt_deck_provider.dart';
import '../widgets/common.dart';
import '../widgets/expandable_fab.dart';

enum ActionTitles {
  progress,
  save,
  shuffle;

  String get label {
    switch (this) {
      case progress:
        return "View Deck Progress";
      case save:
        return "Save card for later";
      case shuffle:
        return "Reshuffle deck";
    }
  }

  Icon get icon {
    switch (this) {
      case progress:
        return const Icon(Icons.view_carousel_outlined);
      case save:
        return const Icon(Icons.save_outlined);
      case shuffle:
        return const Icon(Icons.shuffle);
    }
  }

  static List<ActionTitles> list = [progress, save, shuffle];

  static List<String> strList = [progress.label, save.label, shuffle.label];

  static List<Icon> icons = [];
}

/// PlayScreen/MainScreen shows a deck of cards and animates
/// it when its shuffled.
class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(ActionTitles.strList[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

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
          floatingActionButton: ExpandableFab(
            children: ActionTitles.list
                .asMap()
                .entries
                .map(
                  (entry) => ActionButton(
                    onPressed: () => _showAction(context, entry.key),
                    icon: entry.value.icon,
                    tooltip: entry.value.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildScreenLayout(PromptCardDeckObject currentDeck) {
    final bgColor = DeckType.getDeckBgColor(currentDeck.name);
    final slice =
        PromptCardDeckObject.shuffle(currentDeck).cards.sublist(0, 10);

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
        Common.gap(),
        Container(
          margin: EdgeInsets.all(20),
          width: 250,
          height: 325,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              ...slice.asMap().entries.map((entry) => entry.value).map(
                    (card) => Positioned(
                      child: Card(
                        elevation: 4,
                        color: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _buildCardTitle(card),
                            _buildCardContent(card),
                            _buildCardFooter(card),
                          ],
                        ),
                      ),
                    ),
                  ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => {debugPrint("ok")},
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Common.gap(),
        _buildCurrentDeckNameRow(currentDeck),
        Container(
          padding: EdgeInsets.all(24),
          child: Text(currentDeck.description),
        )
      ],
    );
  }

  Widget _buildCardTitle(PromptCardObject card) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Text(card.title, style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildCardContent(PromptCardObject card) {
    return Flexible(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            card.description,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  /// The card's footer shows its duration and difficulty
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
      ],
    );
    final duration = card.duration.toString();
    final difficulty = titlecase(card.difficulty);
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text("Duration: $duration minutes", style: style),
          Text("Difficulty: $difficulty", style: style),
        ],
      ),
    );
  }

  Widget _buildCurrentDeckNameRow(PromptCardDeckObject currentDeck) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Current Deck: "),
          Text(
            currentDeck.name,
            style: TextStyle(fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
