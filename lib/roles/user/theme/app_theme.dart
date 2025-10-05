import 'package:flutter/material.dart';

class AppTheme {
  // Dark Theme Colors
  static const darkBackground = Color(0xFF0A0E27);
  static const darkSurface = Color(0xFF1A1F3A);
  static const darkCard = Color(0xFF252B49);
  
  // Light Theme Colors
  static const lightBackground = Color(0xFFF5F7FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFF0F2F5);
  
  // Accent Colors
  static const tealAccent = Color(0xFF00D9FF);
  static const blueAccent = Color(0xFF4A90FF);
  static const greenAccent = Color(0xFF4CAF50);
  static const redAccent = Color(0xFFFF4757);
  static const purpleAccent = Color(0xFF7B68EE);
  static const orangeAccent = Color(0xFFFF9500);
  
  // Gradients
  static const tealGradient = LinearGradient(
    colors: [Color(0xFF00D9FF), Color(0xFF0099FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const purpleGradient = LinearGradient(
    colors: [Color(0xFF7B68EE), Color(0xFF9B59B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: tealAccent,
      cardColor: darkCard,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: blueAccent,
      cardColor: lightCard,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3A)),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3A)),
        bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF1A1F3A)),
        bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF5A6082)),
      ),
    );
  }
}