// Copyright 2025, Stormlight Labs
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/prompt_cards.dart';
import '../../models/prompt_deck_provider.dart';

class DeckBrowserScreen extends ConsumerWidget {
  final String id;
  const DeckBrowserScreen({super.key, required this.id});

  String get filepath => "assets/data/$id.yml";
  DeckType get type => DeckType.fromId(id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(decksProvider);
    return decksAsync.when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (decks) {
        final PromptCardDeckObject deck = decks.getDeck(type);
        return Scaffold(
          appBar: AppBar(title: Text(deck.name)),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text("Deck"),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: deck.cards.length,
                  itemBuilder: (context, index) => GameCardListTile(
                    card: deck.cards[index],
                    type: DeckType.reverse(deck.name),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class GameCardListTile extends StatelessWidget {
  final PromptCardObject card;
  final DeckType type;

  const GameCardListTile({
    super.key,
    required this.card,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: type.bgColor,
          child: Icon(type.icon, color: Colors.white),
        ),
        title: Text(
          card.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          card.description,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        onTap: () => {_showCardDetails(context)},
      ),
    );
  }

  void _showCardDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => GameCardDetailModal(card: card),
    );
  }
}

class GameCardDetailModal extends StatelessWidget {
  final PromptCardObject card;

  const GameCardDetailModal({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.amberAccent,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.bolt_outlined,
                  size: 48,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.title,
                      style: TextStyle(color: Colors.amber),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.yellow[200],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.description,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
