import 'package:flutter/material.dart';

// Palette taken from the site's CSS custom properties:
// --paper #FFFFFF, --offwhite #FAFAFA, --warm #F6F5F3, --ink #0d0d0d,
// --mid #444444, --silver #6a6a6a, --rule #E0E0E0, --gold #C4A97D,
// --sci-hero-gold #b89452.
class AppTheme {
  AppTheme._();

  static const paper = Color(0xFFFFFFFF);
  static const offwhite = Color(0xFFFAFAFA);
  static const warm = Color(0xFFF6F5F3);
  static const ink = Color(0xFF0D0D0D);
  static const mid = Color(0xFF444444);
  static const silver = Color(0xFF6A6A6A);
  static const rule = Color(0xFFE0E0E0);
  static const gold = Color(0xFFC4A97D);
  static const heroGold = Color(0xFFB89452);

  // Kept for existing references to AppTheme.brand/bg/card.
  static const brand = heroGold;
  static const bg = offwhite;
  static const card = warm;

  static ThemeData get theme {
    final scheme = ColorScheme.fromSeed(
      seedColor: gold,
      brightness: Brightness.light,
      surface: offwhite,
      primary: heroGold,
    );
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      colorScheme: scheme,
      scaffoldBackgroundColor: offwhite,
      cardColor: paper,
      dividerColor: rule,
      appBarTheme: const AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0.5,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paper,
        indicatorColor: gold.withValues(alpha: 0.25),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected) ? heroGold : silver,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? heroGold : silver,
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
