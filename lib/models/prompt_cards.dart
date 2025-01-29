import 'dart:math';

import 'package:flutter/material.dart';

class PromptCardDeckObject {
  String name;
  String description;
  String filepath;
  List<PromptCardObject> cards = [];

  PromptCardDeckObject({
    required this.name,
    required this.description,
    required this.filepath,
    this.cards = const [],
  });

  set cardSet(List<PromptCardObject> c) {
    cards = c;
  }
}

class PromptCardObject {
  final String id;
  final String title;
  final int duration;
  final String description;
  final String instructions;
  final String difficulty;

  PromptCardObject(
    this.id,
    this.title,
    this.duration,
    this.description,
    this.instructions,
    this.difficulty,
  );
}

enum DeckType {
  creativity,
  movement,
  rest,
  act,
  dbt,
  cbt,
  custom;

  static List<DeckType> list = [
    DeckType.act,
    DeckType.cbt,
    DeckType.dbt,
    DeckType.movement,
    DeckType.rest,
    DeckType.creativity,
  ];

  factory DeckType.random() {
    Random rand = Random();
    return list[rand.nextInt(DeckType.list.length)];
  }

  factory DeckType.reverse(String deckName) {
    switch (deckName) {
      case "Creativity":
        return DeckType.creativity;
      case 'Motivation & Movement':
        return DeckType.movement;
      case 'Rest & Recharge':
        return DeckType.rest;
      case "ACT":
        return DeckType.act;
      case "DBT":
        return DeckType.dbt;
      case "CBT":
        return DeckType.cbt;
      default:
        return DeckType.custom;
    }
  }

  factory DeckType.fromId(String id) {
    final String filename = "$id.yml";
    switch (filename) {
      case "creativity.yml":
        return DeckType.creativity;
      case 'movement.yml':
        return DeckType.movement;
      case 'recharge.yml':
        return DeckType.rest;
      case "act.yml":
        return DeckType.act;
      case "dbt.yml":
        return DeckType.dbt;
      case "cbt.yml":
        return DeckType.cbt;
      default:
        throw Exception();
    }
  }

  String get filename {
    switch (this) {
      case DeckType.creativity:
        return "creativity.yml";
      case DeckType.movement:
        return 'movement.yml';
      case DeckType.rest:
        return 'recharge.yml';
      case DeckType.act:
        return "act.yml";
      case DeckType.dbt:
        return "dbt.yml";
      case DeckType.cbt:
        return "cbt.yml";
      default:
        throw Exception();
    }
  }

  String get name {
    switch (this) {
      case DeckType.creativity:
        return "Creativity";
      case DeckType.movement:
        return 'Motivation & Movement';
      case DeckType.rest:
        return 'Rest & Recharge';
      case DeckType.act:
        return "ACT";
      case DeckType.dbt:
        return "DBT";
      case DeckType.cbt:
        return "CBT";
      default:
        return "Custom";
    }
  }

  String get id {
    return filename.split(".").first;
  }

  IconData get icon {
    switch (this) {
      case DeckType.creativity:
        return Icons.brush;
      case DeckType.movement:
        return Icons.fitness_center;
      case DeckType.rest:
        return Icons.bed_outlined;
      case DeckType.act:
      case DeckType.dbt:
      case DeckType.cbt:
        return Icons.library_books;
      default:
        return Icons.circle;
    }
  }

  Color get bgColor {
    switch (this) {
      case DeckType.creativity:
        return Colors.purple[700]!;
      case DeckType.movement:
        return Colors.green[600]!;
      case DeckType.rest:
        return Colors.blue[700]!;
      case DeckType.act:
        return Colors.orange[700]!;
      case DeckType.dbt:
        return Colors.teal[600]!;
      case DeckType.cbt:
        return Colors.indigo[600]!;
      default:
        return Colors.black87;
    }
  }

  Color get color {
    switch (this) {
      case DeckType.creativity:
        return Colors.purpleAccent;
      case DeckType.movement:
        return Colors.greenAccent;
      case DeckType.rest:
        return Colors.blueAccent;
      case DeckType.act:
        return Colors.orangeAccent;
      case DeckType.dbt:
        return Colors.tealAccent;
      case DeckType.cbt:
        return Colors.indigoAccent;
      default:
        return Colors.lightBlueAccent;
    }
  }

  static Color getDeckBgColor(String deckName) {
    return DeckType.reverse(deckName).bgColor;
  }
}
