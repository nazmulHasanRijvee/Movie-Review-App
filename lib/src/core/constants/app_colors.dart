import 'package:flutter/material.dart';

/// Legacy AppColors - mirrors tokens in [_Primitive] for backward compatibility.
/// 
/// Prefer using [context.color] from the theme system.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF002335); // _Primitive.brandPrimary
  static const Color background = Color(0xFF141414); // _Primitive.scaffoldDark
  static const Color surface = Color(0xFF2B2B2B); // _Primitive.surfaceDark
  static const Color textPrimary = Colors.white; // _Primitive.textPrimaryDark
  static const Color textSecondary = Color(0xFF9E9E9E); // _Primitive.unselected
  static const Color accent = Color(0xFFFFC107); // _Primitive.ratingAmber
}
