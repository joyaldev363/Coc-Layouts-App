import 'package:flutter/material.dart';

/// AppRadius defines standardized border radii used across the app.
class AppRadius {
  AppRadius._();

  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 16.0;
  static const double extraLarge = 24.0;
  static const double circular = 100.0; // Fully rounded corners

  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(small));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(medium));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(large));
  static const BorderRadius extraLargeRadius = BorderRadius.all(Radius.circular(extraLarge));
  static const BorderRadius circularRadius = BorderRadius.all(Radius.circular(circular));
}
