import 'package:flutter/material.dart';

final ThemeData brinquedotecaTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,

    primary: const Color(0xFF90CAF9), // Azul pastel
    onPrimary: const Color(0xFF29434E),
    primaryContainer: const Color(0xFFE3F2FD),
    onPrimaryContainer: const Color(0xFF1E3A4C),

    secondary: const Color(0xFFF3A92B), // Laranja bebê
    onSecondary: const Color(0xFF4E342E),
    secondaryContainer: const Color(0xFFFFF3E0),
    onSecondaryContainer: const Color(0xFF5D4037),

    tertiary: const Color(0xFFA5D6A7), // Verde menta claro
    onTertiary: const Color(0xFF1B5E20),
    tertiaryContainer: const Color(0xFFE8F5E9),
    onTertiaryContainer: const Color(0xFF2E7D32),

    error: Colors.red.shade700,
    onError: Colors.white,

    background: const Color(0xFFFAFAFA),
    onBackground: const Color(0xFF37474F),

    surface: Colors.white,
    onSurface: const Color(0xFF37474F),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF90CAF9), // Azul pastel
    foregroundColor: Color(0xFF29434E), // Texto mais suave
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFD180),
    foregroundColor: Color(0xFF4E342E),
  ),
);
