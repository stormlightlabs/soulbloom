// Copyright 2025, Stormlight Labs

import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Soulbloom"),
        ),
        body: Column(
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF4f8fba),
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 20),
          unselectedFontSize: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: "Play",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark),
                label: "Browser",
                tooltip: "View your cards"),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_sharp),
                label: "Journal",
                tooltip: "Your notes and settings"),
          ],
        ));
  }

  static const _gap = SizedBox(height: 10);
}
