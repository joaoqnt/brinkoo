import 'package:flutter/material.dart';

/// =======================
/// 🎨 PALETA BASE
/// =======================

// Rosa (Primary / Brand)
const pk = Color(0xFFD4537E);
const pkDark = Color(0xFFB43E66);
const pkLight = Color(0xFFF8E6EC);
const pkBorder = Color(0xFFE7A5B8);

// Verde (Success)
const tl = Color(0xFF1D9E75);
const tlDark = Color(0xFF167A5B);
const tlLight = Color(0xFFE4F5EF);
const tlBorder = Color(0xFF8FD3BD);

// Âmbar (Warning)
const am = Color(0xFFBA7517);
const amDark = Color(0xFF8F5A12);
const amLight = Color(0xFFF6E7D2);
const amBorder = Color(0xFFE2B87A);

// Vermelho (Error / Danger)
const rd = Color(0xFFA32D2D);
const rdDark = Color(0xFF7A2121);
const rdLight = Color(0xFFFAEEEE);
const rdBorder = Color(0xFFE2A0A0);

// Azul (Info / neutro funcional)
const bl = Color(0xFF185FA5);
const blDark = Color(0xFF12497F);
const blLight = Color(0xFFE3EEF8);
const blBorder = Color(0xFF8FB7E0);

// Roxo (Planos)
const pu = Color(0xFF534AB7);
const puDark = Color(0xFF3F3890);
const puLight = Color(0xFFE9E7F9);
const puBorder = Color(0xFFB3ADF0);

// Neutros rosados
const bg = Color(0xFFF8F4F6);
const textPrimary = Color(0xFF1A0A12);
const textSecondary = Color(0xFF5C3D4E);
const textHint = Color(0xFF9E7A8A);


/// =======================
/// 🎯 THEME
/// =======================

final ThemeData brinquedotecaTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: bg,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    primary: pk,
    onPrimary: Colors.white,

    secondary: bl,
    onSecondary: Colors.white,

    tertiary: pu,

    error: rd,
    onError: Colors.white,

    surface: Colors.white,
    onSurface: textPrimary,

    background: bg,
    onBackground: textPrimary,
  ),

  /// 📝 TEXTOS (escala rosada)
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: textPrimary,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: textPrimary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: textSecondary,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: textPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: textHint,
    ),
  ),

  /// 🔝 APP BAR (marca forte)
  appBarTheme: const AppBarTheme(
    backgroundColor: pk,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
  ),

  /// 🔘 BOTÕES PRINCIPAIS
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: pk,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),

  /// 🔘 BOTÃO SECUNDÁRIO (info)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: bl,
      side: const BorderSide(color: blBorder),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),

  /// ➕ FAB
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: pk,
    foregroundColor: Colors.white,
    elevation: 2,
  ),

  /// 🧾 CARDS (borda leve + fundo neutro)
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: pkLight),
    ),
  ),

  /// 🧾 INPUTS
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: textHint),
    labelStyle: const TextStyle(color: textSecondary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: pkBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: pkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: pk, width: 1.5),
    ),
  ),

  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300
  )
);