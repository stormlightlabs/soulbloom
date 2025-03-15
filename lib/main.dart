// Copyright 2025, Stormlight Labs

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as r;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:soulbloom/models/app_lifecycle.dart';
import 'package:soulbloom/models/controllers/audio_controller.dart';
import 'package:soulbloom/models/controllers/settings_controller.dart';
import 'package:soulbloom/models/prompt_deck_provider.dart';
import 'package:soulbloom/models/theme/theme_data.dart';
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
          Provider(create: (context) => SoulbloomTheme.defaultTheme())
        ],
        child: Builder(
          builder: (context) {
            final themeData = context.watch<SoulbloomTheme>().themeData;

            return MaterialApp.router(
              title: 'Soulbloom',
              theme: themeData,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
