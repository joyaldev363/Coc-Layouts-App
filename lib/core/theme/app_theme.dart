import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// AppTheme orchestrates light and dark themes.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => LightTheme.theme;
  static ThemeData get darkTheme => DarkTheme.theme;
}
