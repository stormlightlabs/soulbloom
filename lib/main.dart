// Copyright 2025, Stormlight Labs

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'audio/audio_controller.dart';
import 'models/app_lifecycle.dart';
import 'router/router_config.dart';
import 'screens/settings/settings.dart';
import 'style/palette.dart';

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

  runApp(river.ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => SettingsController()),
          Provider(create: (context) => Palette()),
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
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();

          return MaterialApp.router(
            title: 'Soulbloom',
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                surface: palette.backgroundMain,
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontFamily: "Jersey 25",
                  letterSpacing: 0.5,
                  fontSize: 32,
                  color: palette.trueWhite,
                ),
                bodyMedium: TextStyle(
                  fontSize: 24,
                  fontFamily: "Jersey 25",
                  letterSpacing: 0.25,
                  color: palette.trueWhite,
                ),
                bodySmall: TextStyle(
                  fontFamily: "Jersey 25",
                  fontSize: 16,
                  letterSpacing: 0.25,
                  color: palette.trueWhite,
                ),
              ),
              useMaterial3: true,
            ).copyWith(
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            routerConfig: router,
          );
        }),
      ),
    );
  }
}
