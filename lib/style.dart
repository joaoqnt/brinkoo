import 'package:flutter/material.dart';

final ThemeData brinquedotecaTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    // Roxo vibrante como cor primária (alegre, chamativa e amigável)
    primary: Color(0xFF9C27B0), // Roxo médio vibrante
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFF3E5F5), // Roxo bem clarinho (fundo de containers)
    onPrimaryContainer: Color(0xFF4A148C), // Roxo escuro

    // Secundária puxada pro magenta/pink (divertida e moderna)
    secondary: Color(0xFFE91E63), // Rosa pink vibrante
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFF8BBD0),
    onSecondaryContainer: Color(0xFF880E4F),

    // Terciária puxada pro lilás/menta (refrescante e amigável)
    tertiary: Color(0xFFBA68C8), // Lilás forte
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFE1BEE7),
    onTertiaryContainer: Color(0xFF4A0072),

    error: Colors.red,
    onError: Colors.white,

    background: Color(0xFFFDF4FF), // Fundo lilás muito claro
    onBackground: Color(0xFF3E2C4A), // Roxo acinzentado escuro

    surface: Colors.white,
    onSurface: Color(0xFF3E2C4A),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Color(0xFF4A148C),
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: Color(0xFF4A148C),
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFF3E2C4A),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE91E63),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF9C27B0),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFE91E63),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF9C27B0),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    shadowColor: Colors.purple.withOpacity(0.2),
    margin: const EdgeInsets.all(10),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF3E5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
    ),
    labelStyle: const TextStyle(color: Color(0xFF4A148C)),
    hintStyle: const TextStyle(color: Colors.black45),
  ),
);
