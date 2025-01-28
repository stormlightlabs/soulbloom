// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Title(color: Colors.white, child: Text("Good morning, ")),
            Title(color: Colors.white, child: Text("Player")),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
        Center(
          child: Text("Deck Name"),
        ),
        _gap,
        Center(
          child: Stack(
            children: [
              Card(
                color: Colors.transparent,
                margin: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => {debugPrint("tapped card")},
                  splashColor: Colors.blueGrey,
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Text("card"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _gap,
        Text("Deck Description"),
      ],
    );
  }

  static const _gap = SizedBox(height: 10);
}
