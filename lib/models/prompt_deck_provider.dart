import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import './prompt_cards.dart';

class DeckContainer {
  final PromptCardDeckObject creativityDeck;
  final PromptCardDeckObject movementDeck;
  final PromptCardDeckObject rechargeDeck;
  final PromptCardDeckObject actDeck;
  final PromptCardDeckObject cbtDeck;
  final PromptCardDeckObject dbtDeck;

  const DeckContainer({
    required this.creativityDeck,
    required this.movementDeck,
    required this.rechargeDeck,
    required this.actDeck,
    required this.cbtDeck,
    required this.dbtDeck,
  });

  factory DeckContainer.fromMapping(Map<String, PromptCardDeckObject> data) {
    return DeckContainer(
      actDeck: data[DeckType.act.name]!,
      cbtDeck: data[DeckType.cbt.name]!,
      dbtDeck: data[DeckType.dbt.name]!,
      creativityDeck: data[DeckType.creativity.name]!,
      movementDeck: data[DeckType.movement.name]!,
      rechargeDeck: data[DeckType.rest.name]!,
    );
  }

  List<PromptCardDeckObject> toList() => [
        creativityDeck,
        movementDeck,
        rechargeDeck,
        actDeck,
        cbtDeck,
        dbtDeck,
      ];

  PromptCardDeckObject getDeck(DeckType type) {
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

class DecksNotifier extends AsyncNotifier<DeckContainer> {
  Future<DeckContainer> _loadDecks() async {
    Map<String, PromptCardDeckObject> result = <String, PromptCardDeckObject>{};
    try {
      for (var element in DeckType.list) {
        final filename = element.filename;
        final filepath = "assets/data/$filename";
        final String content = await rootBundle.loadString(filepath);
        final YamlMap data = loadYaml(content) as YamlMap;

        var currentDeck = PromptCardDeckObject(
          name: data["name"] as String,
          description: data["description"] as String,
          filepath: filepath,
          type: element,
        );

        currentDeck.cardSet = ((data["cards"] as YamlList).map(
          (cardEl) {
            YamlMap cardElement = cardEl as YamlMap;

            return PromptCardObject(
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

      return DeckContainer.fromMapping(result);
    } catch (e) {
      throw Exception('Failed to load cards: $e');
    }
  }

  Future<void> refreshCards() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadDecks());
  }

  @override
  Future<DeckContainer> build() async {
    return _loadDecks();
  }
}

final decksProvider = AsyncNotifierProvider<DecksNotifier, DeckContainer>(
  () => DecksNotifier(),
);
