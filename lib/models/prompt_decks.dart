import 'prompt_cards.dart';

List<PromptCardDeckObject> promptDecks = [
  PromptCardDeckObject(
    name: DeckType.movement.name,
    description: 'Energizing exercises to boost mood and physical activity.',
    cards: [],
    filepath: "assets/data/movement.yml",
  ),
  PromptCardDeckObject(
    name: DeckType.rest.name,
    description: 'Calming activities for relaxation and stress relief.',
    cards: [],
    filepath: "assets/data/recharge.yml",
  ),
  PromptCardDeckObject(
    name: 'Creativity',
    description: 'Exercises to spark imagination and creative thinking.',
    cards: [],
    filepath: "assets/data/creativity.yml",
  ),
  PromptCardDeckObject(
    name: 'ACT',
    description: 'Acceptance and Commitment Therapy exercises.',
    cards: [],
    filepath: '/assets/data/act.yml',
  ),
  PromptCardDeckObject(
    name: 'CBT',
    description: 'Cognitive Behavioral Therapy techniques.',
    cards: [],
    filepath: '/assets/data/cbt.yml',
  ),
  PromptCardDeckObject(
    name: 'DBT',
    description: 'Dialectical Behavior Therapy skills practice.',
    cards: [],
    filepath: '/assets/data/dbt.yml',
  ),
];
