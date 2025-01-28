class PromptCardDeckObject {
  String category;
  String description;
  List<PromptCardObject> cards = [];

  PromptCardDeckObject(this.category, this.description, this.cards);
}

class PromptCardObject {
  final String id;
  final String title;
  final String description;
  final String instructions;
  final int duration;

  PromptCardObject(
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.duration,
    // Optional
    // this.position,
    // this.benefits,
  );
}
