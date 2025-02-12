import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SoulbloomShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const SoulbloomShell({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Soulbloom",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        automaticallyImplyLeading: true,
      ),
      body: navigationShell,
      bottomNavigationBar: _buildNavigation(),
    );
  }

  Widget _buildNavigation() {
    return NavigationBar(
      backgroundColor: Color(0xFF059669),
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.play_arrow), label: "Play"),
        NavigationDestination(
          icon: Icon(Icons.collections_bookmark),
          label: "Browser",
          tooltip: "View your cards",
        ),
        NavigationDestination(
          icon: Icon(Icons.my_library_books_sharp),
          label: "Journal",
          tooltip: "Your notes and settings",
        ),
      ],
    );
  }
}
