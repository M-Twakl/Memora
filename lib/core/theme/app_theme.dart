import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Centralized ThemeData configuration.
abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.darkBlue,
        surface: AppColors.splashBackground,
        error: AppColors.accentPink,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        headlineLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading2,
        headlineSmall: AppTextStyles.heading3,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
      ),
    );
  }
}
