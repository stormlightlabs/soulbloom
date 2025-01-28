class PromptCardDeckObject {
  String category;
  String description;
  List<PromptCardObject> cards = [];

  PromptCardDeckObject(this.category, this.description, this.cards);
}

class PromptCardObject {
  final String id;
  final String title;
  final String type;
  final String description;
  final String instructions;
  final double duration;
  String? position;
  String? benefits;

  PromptCardObject(
    this.id,
    this.title,
    this.type,
    this.description,
    this.duration,
    this.instructions,
    // Optional
    this.position,
    this.benefits,
  );
}
