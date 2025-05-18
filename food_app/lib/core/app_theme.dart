import 'package:flutter/material.dart';

import 'app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appThemeData = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade50,
      filled: true,
      hintStyle: const TextStyle(
        color: AppColors.textGrey1,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black, size: 35),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColors.primaryColor,
      secondary: Colors.pink,
      tertiary: Colors.amber,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',

        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        // fontFamily: GoogleFonts.eagleLake().fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
