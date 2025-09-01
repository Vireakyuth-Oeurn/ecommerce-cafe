import 'package:flutter/material.dart';

class CoffeeTheme {
  // Coffee Color Palette
  static const Color coffeeMain = Color(0xFF8B4513); // Rich coffee brown
  static const Color coffeeDark = Color(0xFF5D2F0A); // Dark roasted brown
  static const Color coffeeLight = Color(0xFFD2B48C); // Light tan
  static const Color coffeeAccent = Color(0xFFCD853F); // Copper accent
  static const Color coffeeCream = Color(0xFFF5E6D3); // Cream color
  static const Color coffeeBackground =
      Color(0xFFFAF7F0); // Off-white background

  // Radius Constants
  static const double cardRadius = 20.0;
  static const double buttonRadius = 16.0;
  static const double smallRadius = 12.0;
  static const double inputRadius = 14.0;

  // Text Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: coffeeMain.withOpacity(0.3),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  // Theme Data
  static ThemeData get themeData {
    return ThemeData(
      primarySwatch: MaterialColor(
        0xFF8B4513,
        <int, Color>{
          50: coffeeBackground,
          100: coffeeCream,
          200: coffeeLight,
          300: coffeeAccent,
          400: coffeeMain.withOpacity(0.7),
          500: coffeeMain,
          600: coffeeDark,
          700: coffeeDark,
          800: coffeeDark,
          900: coffeeDark,
        },
      ),
      primaryColor: coffeeMain,
      scaffoldBackgroundColor: coffeeBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: coffeeMain,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coffeeMain,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: BorderSide(color: coffeeMain, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: coffeeMain,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallRadius),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
