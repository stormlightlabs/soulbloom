import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/prompt_cards.dart';
import '../../models/prompt_deck_provider.dart';

class DeckSelectionScreen extends ConsumerWidget {
  const DeckSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(decksProvider);
    return decksAsync.when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (decks) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Select a Deck"),
            automaticallyImplyLeading: false,
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: decks.toList().length,
                  itemBuilder: (context, index) {
                    final deck = decks.toList()[index];
                    return Card(
                      color: DeckType.getDeckBgColor(deck.name),
                      elevation: 4,
                      child: _buildCardContent(context, deck),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent(BuildContext context, PromptCardDeckObject deck) {
    final TextTheme theme = Theme.of(context).textTheme;
    final String filename = deck.filepath.split("/").last;
    final String id = filename.split(".").first;
    return ListTile(
      onTap: () => GoRouter.of(context).go("/decks/$id"),
      leading: Icon(
        DeckType.fromId(id).icon,
        color: Colors.white,
      ),
      title: Text(deck.name, style: theme.titleLarge),
      subtitle: Text(deck.description,
          style: TextStyle(fontSize: 16, color: Colors.white)),
      isThreeLine: true,
    );
  }
}
