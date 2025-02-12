// Copyright 2025, Stormlight Labs

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import './prompt_cards.dart';

class DeckBox {
  final DeckObject creativityDeck;
  final DeckObject movementDeck;
  final DeckObject rechargeDeck;
  final DeckObject actDeck;
  final DeckObject cbtDeck;
  final DeckObject dbtDeck;

  const DeckBox({
    required this.creativityDeck,
    required this.movementDeck,
    required this.rechargeDeck,
    required this.actDeck,
    required this.cbtDeck,
    required this.dbtDeck,
  });

  factory DeckBox.fromMapping(Map<String, DeckObject> data) {
    return DeckBox(
      actDeck: data[DeckType.act.name]!,
      cbtDeck: data[DeckType.cbt.name]!,
      dbtDeck: data[DeckType.dbt.name]!,
      creativityDeck: data[DeckType.creativity.name]!,
      movementDeck: data[DeckType.movement.name]!,
      rechargeDeck: data[DeckType.rest.name]!,
    );
  }

  List<DeckObject> toList() => [
        creativityDeck,
        movementDeck,
        rechargeDeck,
        actDeck,
        cbtDeck,
        dbtDeck,
      ];

  DeckObject getDeck(DeckType type) {
    switch (type) {
      case DeckType.creativity:
        return creativityDeck;
      case DeckType.movement:
        return movementDeck;
      case DeckType.rest:
        return rechargeDeck;
      case DeckType.act:
        return actDeck;
      case DeckType.dbt:
        return dbtDeck;
      case DeckType.cbt:
        return cbtDeck;
      default:
        throw Exception();
    }
  }
}

Future<Map<String, DeckObject>> loadDecks() async {
  Map<String, DeckObject> result = <String, DeckObject>{};
  try {
    for (var element in DeckType.list) {
      final filename = element.filename;
      final filepath = "assets/data/$filename";
      final String content = await rootBundle.loadString(filepath);
      final YamlMap data = loadYaml(content) as YamlMap;

      var currentDeck = DeckObject(
        name: data["name"] as String,
        description: data["description"] as String,
        filepath: filepath,
        type: element,
      );

      currentDeck.cardSet = ((data["cards"] as YamlList).map(
        (cardEl) {
          YamlMap cardElement = cardEl as YamlMap;

          return CardObject(
            cardElement["id"] as String,
            cardElement["title"] as String,
            cardElement["duration"] as int,
            cardElement["description"] as String,
            cardElement["instructions"] as String,
            cardElement["difficulty"] as String,
          );
        },
      ).toList());

      result[element.name] = currentDeck;
    }

    return result;
  } catch (e) {
    throw Exception('Failed to load cards: $e');
  }
}

/// We want this to be synchronously available, despite files being loaded
/// asynchronously. To do this, we use a provider that throws an error if it's
/// accessed before the data is loaded.
///
/// In the application's entrypoint, this is overriden with the contents loaded
/// in [loadDecks], as starting the application lifecycle is in a future. We
/// also define a notifier that watches for updates to the data provider for a
/// [DeckBox] object.
///
/// By the time the notifier is accessed, the data is already loaded.
final deckBoxProvider = Provider<DeckBox>((ref) => throw UnimplementedError());

class DeckBoxNotifier extends Notifier<DeckBox> {
  @override
  DeckBox build() => ref.watch(deckBoxProvider);
}

final deckBoxNotifierProvider = NotifierProvider<DeckBoxNotifier, DeckBox>(
  DeckBoxNotifier.new,
);
