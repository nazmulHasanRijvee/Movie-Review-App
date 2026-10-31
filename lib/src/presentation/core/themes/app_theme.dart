import 'package:flutter/material.dart';
// import 'package:cinephiler/src/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    textTheme: textTheme,
    //scaffoldBackgroundColor: AppColors.primary,
    outlinedButtonTheme: outlinedButtonTheme,
    elevatedButtonTheme: elevatedButtonTheme,
  );

  static TextTheme get textTheme => TextTheme(
    titleLarge: TextStyle(fontSize: 34, fontWeight: .bold, color: Colors.white),
    titleMedium: TextStyle(fontSize: 28, color: Colors.white),
    titleSmall: TextStyle(fontSize: 26, color: Colors.white),
    bodyLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.manrope(),
  );

  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.yellowAccent, width: 1.5),
          // backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          // backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        ),
      );
}
