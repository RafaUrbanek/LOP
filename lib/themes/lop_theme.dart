import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lopTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1D2A38), // Azul Espacial Claro
  scaffoldBackgroundColor: const Color(0xFF0D1B2A), // Azul Espacial
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF0D1B2A), // Azul Espacial
    surfaceTintColor: const Color(0xFFE0E1DD), // Branco Nebuloso
    titleTextStyle: TextStyle(
      color: const Color(0xFFE0E1DD), // Branco Nebuloso
      fontSize: 25,
      fontFamily: GoogleFonts.lexendGiga().fontFamily,
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFE0E1DD), // Azul Espacial Claro
    secondary: Color(0xFF9D4EDD), // Lilás Cósmico
    surface: Color(0xFF1D2A38), // Para botões elevados
    onPrimary: Color(0xFFE0E1DD), // Texto sobre cor primária
    onSecondary: Color(0xFFE0E1DD), // Texto sobre cor secundária
    onSurface: Color(0xFFE0E1DD), // Texto sobre botões
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFFE0E1DD), fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Color(0xFFE0E1DD), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFFC5C6C7), fontSize: 14),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF00E5FF), // Ciano Fluorescente
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1D2A38), // Azul Espacial Claro
      foregroundColor: const Color(0xFFE0E1DD), // Branco Nebuloso
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF0D1B2A), // Azul Espacial
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF1D2A38), // Azul Espacial Claro
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1D2A38), // Azul Espacial Claro
  ),
);
