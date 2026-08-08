import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// AppTextTheme defines consistent typography across the application.
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get lightTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: AppSizes.fontHeadline, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      displayMedium: TextStyle(fontSize: AppSizes.fontExtraLarge, fontWeight: FontWeight.bold, color: AppColors.onBackground),
      bodyLarge: TextStyle(fontSize: AppSizes.fontLarge, fontWeight: FontWeight.normal, color: AppColors.onBackground),
      bodyMedium: TextStyle(fontSize: AppSizes.fontMedium, fontWeight: FontWeight.normal, color: AppColors.onBackground),
      bodySmall: TextStyle(fontSize: AppSizes.fontSmall, fontWeight: FontWeight.normal, color: AppColors.onBackground),
      labelLarge: TextStyle(fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w600, color: AppColors.onBackground),
    );
  }

  static TextTheme get darkTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: AppSizes.fontHeadline, fontWeight: FontWeight.bold, color: AppColors.onPrimary),
      displayMedium: TextStyle(fontSize: AppSizes.fontExtraLarge, fontWeight: FontWeight.bold, color: AppColors.onPrimary),
      bodyLarge: TextStyle(fontSize: AppSizes.fontLarge, fontWeight: FontWeight.normal, color: AppColors.onPrimary),
      bodyMedium: TextStyle(fontSize: AppSizes.fontMedium, fontWeight: FontWeight.normal, color: AppColors.onPrimary),
      bodySmall: TextStyle(fontSize: AppSizes.fontSmall, fontWeight: FontWeight.normal, color: AppColors.onPrimary),
      labelLarge: TextStyle(fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w600, color: AppColors.onPrimary),
    );
  }
}
