import 'package:flutter/material.dart';

extension ThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isLightTheme => Theme.of(this).brightness == Brightness.light;
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
