import 'package:flutter/material.dart';

class ThemeColors {
  final Color gray0;
  final Color gray10;
  final Color gray20;
  final Color gray30;
  final Color gray40;
  final Color gray50;
  final Color gray60;
  final Color gray70;
  final Color gray80;
  final Color gray90;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color error;


  ThemeColors({
    required this.gray0,
    required this.gray10,
    required this.gray20,
    required this.gray30,
    required this.gray40,
    required this.gray50,
    required this.gray60,
    required this.gray70,
    required this.gray80,
    required this.gray90,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.error,
  });

  static ThemeColors of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeColors(
      gray0: isDarkMode ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
      gray10: isDarkMode ? const Color(0xFF0D0D0D) : const Color(0xFFFAFAFA),
      gray20: isDarkMode ? const Color(0xFF1C1C1C) : const Color(0xFFF5F5F5),
      gray30: isDarkMode ? const Color(0xFF2E2E2E) : const Color(0xFFEBEBEB),
      gray40: isDarkMode ? const Color(0xFF3B3B3B) : const Color(0xFFDEDEDE),
      gray50: isDarkMode ? const Color(0xFF4A4A4A) : const Color(0xFFBFBFBF),
      gray60: isDarkMode ? const Color(0xFF575757) : const Color(0xFFB0B0B0),
      gray70: isDarkMode ? const Color(0xFF666666) : const Color(0xFFA3A3A3),
      gray80: isDarkMode ? const Color(0xFF757575) : const Color(0xFF949494),
      gray90: isDarkMode ? const Color(0xFF858585) : const Color(0xFF858585),
      gray100: isDarkMode ? const Color(0xFF949494) : const Color(0xFF757575),
      gray200: isDarkMode ? const Color(0xFFA3A3A3) : const Color(0xFF666666),
      gray300: isDarkMode ? const Color(0xFFB0B0B0) : const Color(0xFF575757),
      gray400: isDarkMode ? const Color(0xFFBFBFBF) : const Color(0xFF4A4A4A),
      gray500: isDarkMode ? const Color(0xFFDEDEDE) : const Color(0xFF3B3B3B),
      gray600: isDarkMode ? const Color(0xFFEBEBEB) : const Color(0xFF2E2E2E),
      gray700: isDarkMode ? const Color(0xFFF5F5F5) : const Color(0xFF1C1C1C),
      gray800: isDarkMode ? const Color(0xFFFAFAFA) : const Color(0xFF0D0D0D),
      gray900: isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      primary: const Color(0xFF01C674),
      secondary: const Color(0xFF1E9F69),
      tertiary: const Color(0xFF2E7155),
      background: isDarkMode ? const Color(0xFF2C2B28) : const Color(0xFFF8FAED),
      error: const Color(0xFFFF6B6B),
    );
  }
}