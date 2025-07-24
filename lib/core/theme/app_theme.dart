import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF292E34),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
      titleLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2B64DF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.white),
    ),
  );
}
