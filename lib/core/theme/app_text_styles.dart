import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized application typography styles using the Alexandria font family
/// directly matching the Figma design system.
abstract class AppTextStyles {
  // Display & Headings
  static TextStyle get displayLarge => GoogleFonts.alexandria(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get heading1 => GoogleFonts.alexandria(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.alexandria(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading3 => GoogleFonts.alexandria(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.alexandria(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get bodySmall => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      );

  // Buttons & Labels
  static TextStyle get button => GoogleFonts.alexandria(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: 0.2,
      );

  static TextStyle get caption => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  // Onboarding Typography (Exact Alexandria from Figma)
  static TextStyle get onboardingTitle => GoogleFonts.alexandria(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryBlue,
        height: 1.25,
      );

  static TextStyle get onboardingSubtitle => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.textOnboardingDark,
        height: 1.4,
      );

  static TextStyle get onboardingSkip => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.textSkip,
      );
}
