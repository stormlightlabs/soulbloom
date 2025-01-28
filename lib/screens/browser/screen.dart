// Copyright 2025, Stormlight Labs
// TODO: Implement loadData to read the assets/data directory
//  then create a list of PromptCardDeck objects.
// TODO: Handle persistence of custom cards
// TODO: Move to PromptCardDeckService
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../../models/prompt_cards.dart';

class DeckBrowserScreen extends StatefulWidget {
  const DeckBrowserScreen({super.key});

  @override
  State<DeckBrowserScreen> createState() => _DeckBrowserScreenState();
}

class _DeckBrowserScreenState extends State<DeckBrowserScreen> {
  Future<PromptCardDeckObject> _promptCardDeck() async {
    String content = await rootBundle.loadString("assets/data/movement.yml");

    YamlMap data = loadYaml(content) as YamlMap;

    List<PromptCardObject> cards = (data["cards"] as YamlList)
        .map(
          (element) => PromptCardObject(
            element["id"] as String,
            element["title"] as String,
            element["description"] as String,
            element["instructions"] as String,
            element["duration"] as int,
          ),
        )
        .toList();

    PromptCardDeckObject deck = PromptCardDeckObject(
        data["category"] as String, data["description"] as String, cards);

    return deck;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PromptCardDeckObject>(
        future: _promptCardDeck(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.none:
              return Center(child: Text("Empty File"));
            default:
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Deck"),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.cards.length,
                        itemBuilder: (context, index) {
                          return GameCardListTile(
                              card: snapshot.data!.cards[index]);
                        },
                      )
                    ],
                  ),
                ),
              );
          }
        });
  }
}

class GameCardListTile extends StatelessWidget {
  final PromptCardObject card;

  const GameCardListTile({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.yellow[200],
          child: Icon(Icons.bolt, color: Colors.amber),
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
