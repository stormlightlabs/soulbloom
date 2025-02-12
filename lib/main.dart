// Copyright 2025, Stormlight Labs

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as r;
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:soulbloom/models/app_lifecycle.dart';
import 'package:soulbloom/models/controllers/audio_controller.dart';
import 'package:soulbloom/models/controllers/settings_controller.dart';
import 'package:soulbloom/models/prompt_deck_provider.dart';
import 'package:soulbloom/router/router_config.dart';

void main() async {
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final mapping = await loadDecks();
  final deckBox = DeckBox.fromMapping(mapping);

  runApp(r.ProviderScope(
    overrides: [
      // This allows us to preload the YAML backed decks
      // so that they're available once the app finishes
      // loading.
      deckBoxProvider.overrideWithValue(deckBox),
    ],
    child: MyApp(),
  ));
}

class MyApp extends r.ConsumerWidget {
  const MyApp({super.key});

  TextStyle get _ptMono => GoogleFonts.ptMono();

  TextStyle get _dmSans => GoogleFonts.dmSans();

  TextStyle get _bodyStyle {
    return TextStyle(
      fontFamily: _dmSans.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  TextStyle get _labelStyle {
    return TextStyle(
      fontFamily: _dmSans.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.25,
    );
  }

  TextStyle get _displayStyle {
    return TextStyle(
      fontFamily: _ptMono.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    );
  }

  ThemeData get _theme {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue[800]!,
        surface: Color(0xff84a98c),
        onSecondary: Colors.white,
        secondary: Colors.blueAccent,
      ),
      textTheme: TextTheme(
        displayLarge: _displayStyle.copyWith(
          fontSize: 64,
          shadows: [
            Shadow(
              color: Colors.green[900]!.withValues(alpha: 0.9),
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
        displayMedium: _displayStyle.copyWith(fontSize: 48),
        displaySmall: _displayStyle.copyWith(fontSize: 32),
        labelLarge: _labelStyle.copyWith(fontSize: 24),
        labelMedium: _labelStyle.copyWith(fontSize: 16),
        labelSmall: _labelStyle.copyWith(fontSize: 12),
        bodyLarge: _bodyStyle.copyWith(fontSize: 16),
        bodyMedium: _bodyStyle.copyWith(fontSize: 14),
        bodySmall: _bodyStyle.copyWith(fontSize: 12),
        titleLarge: TextStyle(
          fontFamily: _ptMono.fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
          letterSpacing: -0.5,
          fontSize: 32,
        ),
      ),
      useMaterial3: true,
    ).copyWith(
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, r.WidgetRef ref) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => SettingsController()),
          ProxyProvider2<AppLifecycleStateNotifier, SettingsController,
              AudioController>(
            create: (context) => AudioController(),
            update: (context, lifecycleNotifier, settings, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
            lazy: false,
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Soulbloom',
              theme: _theme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
