part of '../theme_data.dart';

/// Filled Button
///
/// Light Theme
class _FilledButtonLightThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: (WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(const Dimensions().radius.md),
          ),
        )),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.xl),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.xxl),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Dark Theme
class _FilledButtonDarkThemeData with ThemeExtensions {
  FilledButtonThemeData call() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          StadiumBorder(
            side: BorderSide(
              color: darkColor.primary,
              width: dimensions.spacing.xxs,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: dimensions.spacing.xl),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, dimensions.spacing.xxl),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Elevated Button
///
/// Light Theme
class _ElevatedButtonLightThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(5),
        backgroundColor: WidgetStateProperty.all(
          const LightColorExtension().accent.yellow,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(const Dimensions().radius.md),
            // side: BorderSide(
            //   color: lightColor.primary,
            //   width: dimensions.spacing.xxs,
            // ),
          ),
        ),
        // padding: WidgetStateProperty.all(
        //   EdgeInsets.symmetric(horizontal: dimensions.spacing.xl),
        // ),
        // minimumSize: WidgetStateProperty.all(
        //   Size(double.infinity, dimensions.spacing.xxl),
        // ),
        // textStyle: WidgetStateProperty.all(
        //   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // ),
      ),
    );
  }
}

/// Dark Theme
class _ElevatedButtonDarkThemeData with ThemeExtensions {
  ElevatedButtonThemeData call() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(5),
        backgroundColor: WidgetStateProperty.all(
          const DarkColorExtension().accent.yellow,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: .circular(const Dimensions().radius.md),
            // side: BorderSide(
            //   color: darkColor.primary,
            //   width: dimensions.spacing.xxs,
            // ),
          ),
        ),
        // padding: WidgetStateProperty.all(
        //   EdgeInsets.symmetric(horizontal: dimensions.spacing.xl),
        // ),
        // minimumSize: WidgetStateProperty.all(
        //   Size(double.infinity, dimensions.spacing.xxl),
        // ),
        // textStyle: WidgetStateProperty.all(
        //   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // ),
      ),
    );
  }
}

/// Outlined Button
/// Light Theme
class _OutlinedButtonLightThemeData with ThemeExtensions {
  OutlinedButtonThemeData call() {
    final accentColor = const LightColorExtension().accent;

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(accentColor.yellow),
        side: WidgetStateProperty.all(
          BorderSide(
            color: accentColor.yellow,
            width: const Dimensions().spacing.xxxs,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(const Dimensions().radius.md),
          ),
        ),
      ),
    );
  }
}

/// Light Theme
class _OutlinedButtonDarkThemeData with ThemeExtensions {
  OutlinedButtonThemeData call() {
    final accentColor = const DarkColorExtension().accent;

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(accentColor.yellow),
        side: WidgetStateProperty.all(
          BorderSide(
            color: accentColor.yellow,
            width: const Dimensions().spacing.xxxs,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(const Dimensions().radius.md),
          ),
        ),
      ),
    );
  }
}

/// Text Button
///
/// Light Theme
class _TextButtonLightThemeData with ThemeExtensions {
  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(lightColor.text.secondary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// Dark Theme
class _TextButtonDarkThemeData with ThemeExtensions {
  TextButtonThemeData call() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(darkColor.text.secondary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
