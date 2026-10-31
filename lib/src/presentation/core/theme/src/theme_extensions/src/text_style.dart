import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  const TextStyleExtension();

  /// HEADLINES
  TextStyle get headLineLarge {
    return GoogleFonts.poppins(
      height: 1.40,
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get headLineMedium {
    return GoogleFonts.poppins(
      height: 1.40,
      fontSize: 20,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get headLineSmall {
    return GoogleFonts.poppins(
      height: 1.33,
      fontSize: 18,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    );
  }

  /// TITLES
  TextStyle get titleLarge {
    return GoogleFonts.poppins(
      height: 1.25,
      fontSize: 34,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get titleMedium {
    return GoogleFonts.poppins(
      height: 1.25,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get titleSmall {
    return GoogleFonts.poppins(
      height: 1.30,
      fontSize: 26,
      fontWeight: FontWeight.w600,
    );
  }

  /// BODY TEXT
  TextStyle get bodyLarge {
    return GoogleFonts.poppins(
      height: 1.50,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get bodyMedium {
    return GoogleFonts.poppins(
      height: 1.45,
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get bodySmall {
    return GoogleFonts.poppins(
      height: 1.42,
      fontSize: 12,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    );
  }

  /// LABELS
  TextStyle get labelLarge {
    return GoogleFonts.poppins(
      height: 1.15,
      fontSize: 16,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get labelMedium {
    return GoogleFonts.poppins(
      height: 1.15,
      fontSize: 14,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get labelSmall {
    return GoogleFonts.poppins(
      height: 1.15,
      fontSize: 12,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  ThemeExtension<TextStyleExtension> copyWith() => this;

  @override
  ThemeExtension<TextStyleExtension> lerp(
    covariant ThemeExtension<TextStyleExtension>? other,
    double t,
  ) {
    if (other is! TextStyleExtension) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}
