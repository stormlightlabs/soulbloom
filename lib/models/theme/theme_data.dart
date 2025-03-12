// Copyright 2025, Stormlight Labs
//
// Notes:
//  - Fonts used (same as stormlightlabs.org):
//    - Atkinson Hyperlegible for text
//    - DM Sans for headings
//    - Capriola as a serif

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  Color shade100;
  Color shade200;
  Color shade300;
  Color shade400;
  Color shade500;
  Color shade600;
  Color shade700;
  Color shade800;
  Color shade900;
  Color shade950;

  AppColor({
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
    required this.shade950,
  });

  static AppColor from(List<Color> collection) => AppColor(
        shade100: collection[0],
        shade200: collection[1],
        shade300: collection[2],
        shade400: collection[3],
        shade500: collection[4],
        shade600: collection[5],
        shade700: collection[6],
        shade800: collection[7],
        shade900: collection[8],
        shade950: collection[9],
      );
}

class AppColors {
  AppColor get green => AppColor.from(
        [
          Color(0xfff0fdf4),
          Color(0xffdcfce7),
          Color(0xffbbf7d0),
          Color(0xff86efac),
          Color(0xff4ade80),
          Color(0xff22c55e),
          Color(0xff16a34a),
          Color(0xff15803d),
          Color(0xff166534),
          Color(0xff14532d),
        ],
      );
}

class SoulbloomTheme {
  TextStyle sans;
  TextStyle serif;
  TextStyle display;
  AppColors colors = AppColors();

  SoulbloomTheme(this.sans, this.serif, this.display);

  static SoulbloomTheme defaultTheme() => SoulbloomTheme(
        GoogleFonts.atkinsonHyperlegible(),
        GoogleFonts.capriola(),
        GoogleFonts.dmSans(),
      );

  TextStyle get defaultBodyStyle {
    return TextStyle(
      fontFamily: sans.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  TextStyle get defaultLabelStyle {
    return TextStyle(
      fontFamily: display.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.25,
    );
  }

  TextStyle get defaultTitleStyle {
    return TextStyle(
      fontFamily: serif.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    );
  }

  TextStyle get defaultDisplayStyle {
    return TextStyle(
      fontFamily: display.fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.25,
    );
  }

  TextTheme get _titleStyles => TextTheme(
        titleLarge: defaultTitleStyle.copyWith(
          fontSize: 64,
          shadows: [
            Shadow(
              color: colors.green.shade500.withValues(alpha: 0.9),
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
        titleMedium: defaultTitleStyle.copyWith(fontSize: 48),
        titleSmall: defaultTitleStyle.copyWith(fontSize: 32),
      );

  TextTheme get _bodyStyles => TextTheme(
        bodyLarge: defaultBodyStyle.copyWith(fontSize: 24),
        bodyMedium: defaultBodyStyle.copyWith(fontSize: 16),
        bodySmall: defaultBodyStyle.copyWith(fontSize: 12),
      );

  TextTheme get _labelStyles => TextTheme(
        labelLarge: defaultLabelStyle.copyWith(fontSize: 24),
        labelMedium: defaultLabelStyle.copyWith(fontSize: 16),
        labelSmall: defaultLabelStyle.copyWith(fontSize: 12),
      );

  ThemeData get themeData => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.green.shade600,
          surface: colors.green.shade800,
          onSecondary: Colors.white,
          secondary: colors.green.shade700,
        ),
        textTheme: _titleStyles.merge(_bodyStyles).merge(_labelStyles),
        useMaterial3: true,
      ).copyWith(
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: display.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
}
