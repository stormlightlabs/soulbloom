import 'package:flutter/material.dart';
import 'package:soulbloom/screens/browser/screen.dart';
import 'package:soulbloom/screens/journal/screen.dart';
import 'package:soulbloom/screens/play/screen.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PlayScreen(),
    DeckBrowserScreen(),
    JournalScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Soulbloom")),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildNavigation(),
    );
  }

  Widget _buildNavigation() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF4f8fba),
      selectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(fontSize: 20),
      unselectedFontSize: 20,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
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
    );
  }
}
