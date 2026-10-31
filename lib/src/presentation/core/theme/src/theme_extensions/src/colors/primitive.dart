part of 'colors.dart';

/// Primitive color palette
///
/// Map your Figma Design Tokens directly into these slots.
/// Corresponds with legacy [AppColors].
class _Primitive {
  // ===========================================================================
  // 1. BRAND & ACCENTS (Buttons, Active States, Rating Stars)
  // ===========================================================================

  /// Figma: "Primary / Brand" -> used in primary buttons, active indicators (AppColors.primary)
  static const Color brandPrimary = Color(0xFF002335);

  /// Figma: "Brand Deep / Secondary" -> used in secondary surfaces and elements
  static const Color brandSecondary = Color(0xFF00131C);

  /// Figma: "Accent / Rating Star" -> wired to `context.color.accent.yellow` (AppColors.accent)
  static const Color accentYellow = Color(0xFFFFC107);

  /// Secondary yellow shade for highlights and subtle emphasis.
  static const Color accentYellowLight = Color(0xFFFFCA45);

  /// Figma: "Accent / Blue" -> wired to `context.color.accent.blue`
  static const Color accentBlue = Color(0xFF167EE6);

  /// Figma: "Accent / Purple" -> wired to `context.color.accent.purple`
  static const Color accentPurple = Color(0xFF6334C1);

  // ===========================================================================
  // 2. BACKGROUNDS & SURFACES (Scaffolds, Cards, AppBars)
  // ===========================================================================

  /// Figma: "Background / Light" -> light mode scaffold background
  static const Color scaffoldLight = brandPrimary;

  /// Figma: "Background / Dark" -> dark mode scaffold & dark AppBar background (AppColors.background)
  static const Color scaffoldDark = brandPrimary;

  /// Figma: "Surface / Dark Card" -> dialogs, bottom sheets, movie cards (AppColors.surface)
  static const Color surfaceDark = brandSecondary;

  // ===========================================================================
  // 3. TYPOGRAPHY / TEXT COLORS
  // ===========================================================================

  /// Figma: "Text / Light Mode Primary" -> wired to light `context.color.text.primary`
  static const Color textPrimaryLight = Color(0xFFFFFFFF);

  /// Figma: "Text / Light Mode Secondary" -> wired to light `context.color.text.secondary`
  static const Color textSecondaryLight = Color(0xFFD4DADD);

  /// Figma: "Text / Dark Mode Primary" -> wired to dark `context.color.text.primary` (AppColors.textPrimary)
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  /// Figma: "Text / Dark Mode Secondary" -> wired to dark `context.color.text.secondary`
  static const Color textSecondaryDark = Color(0xFFD4DADD);

  // ===========================================================================
  // 4. INPUTS & TEXT FIELDS
  // ===========================================================================
  /// Figma: "Input / Fill" -> text field background color
  static const Color inputFill = brandSecondary;

  /// Figma: "Input / Border" -> text field border color
  static const Color inputBorder = Color(0xFF39596A);

  /// Figma: "Input / Focus Border" -> text field focused border
  static const Color inputFocusBorder = accentYellowLight;

  // ===========================================================================
  // 5. BORDERS, DIVIDERS & ICONS
  // ===========================================================================
  /// Figma: "Border / Light" -> light mode border & dividers
  static const Color borderLight = Color(0xFFE0E0E0);

  /// Figma: "Border / Dark" -> dark mode border & dividers
  static const Color borderDark = Color(0xFF39596A);

  /// Figma: "Icon / Light" -> light mode icon color
  static const Color iconLight = Color(0xFFFFFFFF);

  /// Figma: "Icon / Dark" -> dark mode icon color
  static const Color iconDark = Color(0xFFFFFFFF);

  /// Figma: "Unselected / Inactive" -> unselected tabs, navigation & disabled (AppColors.textSecondary)
  static const Color unselected = Color(0xFFD4DADD);

  // ===========================================================================
  // 6. STATUS / FEEDBACK
  // ===========================================================================
  /// Figma: "Status / Success"
  static const Color success = Color(0xFF008000);

  /// Figma: "Status / Error"
  static const Color error = Color(0xFFFF0000);

  /// Figma: "Status / Warning"
  static const Color warning = Color(0xFFFFFF00);

  /// Figma: "Status / Info"
  static const Color info = brandPrimary;
}
