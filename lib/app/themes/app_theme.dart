import 'package:flutter/material.dart';

class AppTheme {

  const AppTheme._();

  static ThemeData get theme => ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    textTheme: textTheme
  );

  static TextTheme get textTheme => const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    )
  );

}