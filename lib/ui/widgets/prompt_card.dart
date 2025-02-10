import 'package:flutter/material.dart';

import '../../models/prompt_cards.dart';

class PromptCardWidget extends StatelessWidget {
  final PromptCardObject promptCard;
  final String deckName;
  final bool faceUp;
  final double width;
  final double height;
  final Function()? onTap;

  const PromptCardWidget({
    super.key,
    required this.promptCard,
    required this.deckName,
    this.faceUp = true,
    this.width = 70.0,
    this.height = 100.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: DeckType.getDeckBgColor(deckName),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black26),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: const Offset(2.0, 2.0),
            ),
          ],
        ),
        child: faceUp ? _buildCardFace() : _buildCardBack(),
      ),
    );
  }

  Widget _buildCardFace() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                promptCard.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                promptCard.difficulty,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                deckName,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform.rotate(
                angle: 3.14159,
                child: Row(
                  children: [
                    Text(
                      promptCard.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(deckName, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blue,
        backgroundBlendMode: BlendMode.multiply,
      ),
    );
  }
}
