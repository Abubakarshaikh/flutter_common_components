import 'package:flutter/material.dart';

import '../foundation/tokens/app_insets.dart';
import '../foundation/tokens/app_radius.dart';
import 'app_color_schemes.dart';
import 'app_fonts.dart';

/// Builds a [ThemeData] from a [ColorScheme].
///
/// Components never read [AppTheme] directly; they only read Flutter's
/// [ThemeData] plus their own optional [ThemeExtension]. Pass those through
/// [extensions] to restyle a component app-wide.
class AppTheme {
  const AppTheme({
    required this.colorScheme,
    this.textTheme,
    this.extensions = const <ThemeExtension<dynamic>>[],
  });

  factory AppTheme.standard({
    TextTheme? textTheme,
    Iterable<ThemeExtension<dynamic>> extensions =
        const <ThemeExtension<dynamic>>[],
  }) => AppTheme(
    colorScheme: AppColorSchemes.standard,
    textTheme: textTheme,
    extensions: extensions,
  );

  factory AppTheme.dark({
    TextTheme? textTheme,
    Iterable<ThemeExtension<dynamic>> extensions =
        const <ThemeExtension<dynamic>>[],
  }) => AppTheme(
    colorScheme: AppColorSchemes.dark,
    textTheme: textTheme,
    extensions: extensions,
  );

  factory AppTheme.charcoal({
    TextTheme? textTheme,
    Iterable<ThemeExtension<dynamic>> extensions =
        const <ThemeExtension<dynamic>>[],
  }) => AppTheme(
    colorScheme: AppColorSchemes.charcoal,
    textTheme: textTheme,
    extensions: extensions,
  );

  final ColorScheme colorScheme;

  /// Defaults to [AppTextThemes.openSans].
  final TextTheme? textTheme;

  final Iterable<ThemeExtension<dynamic>> extensions;

  ThemeData build() {
    final scheme = colorScheme;
    final inputBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(AppRadius.k2),
      borderSide: BorderSide(width: 0.6, color: scheme.outline),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: (textTheme ?? AppTextThemes.openSans).apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      extensions: extensions,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        iconTheme: IconThemeData(color: scheme.onPrimary),
      ),
      iconTheme: IconThemeData(color: scheme.onSurface),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: scheme.onSurface),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: scheme.onPrimary,
          backgroundColor: scheme.primary,
          padding: AppInsets.k12Vertical,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.k2),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: AppInsets.k4Horizontal,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        errorStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      ),
      dialogTheme: DialogThemeData(backgroundColor: scheme.secondary),
      dividerTheme: DividerThemeData(color: scheme.outline),
      drawerTheme: DrawerThemeData(backgroundColor: scheme.surface),
      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: scheme.onPrimary,
        indicatorColor: scheme.surface,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.onPrimary,
        circularTrackColor: scheme.primary,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStatePropertyAll<Color>(scheme.onPrimary),
      ),
    );
  }
}
