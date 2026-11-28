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

  // Welcome / Auth Gateway Typography
  static TextStyle get welcomeTagline => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        height: 1.5,
      );

  // Login Screen Typography
  static TextStyle get loginTitle => GoogleFonts.alexandria(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnboardingDark,
        height: 1.2,
      );

  static TextStyle get loginSubtitle => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.textOnboardingDark,
        height: 1.4,
      );

  static TextStyle get inputLabel => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get inputHint => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.inputHint,
      );

  static TextStyle get inputText => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get forgotPassword => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get orDividerText => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.black,
      );

  static TextStyle get socialButtonText => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get dontHaveAccountText => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get registerLink => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBlue,
      );

  // Auth States & Notices
  static TextStyle get registrationErrorBanner => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.errorRed,
        height: 1.33,
      );

  static TextStyle get invalidCredentialsNotice => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.errorRed,
        height: 1.33,
      );

  static TextStyle get submittingGuidance => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.submittingText,
        height: 1.33,
      );

  static TextStyle get verifyCodeTimer => GoogleFonts.alexandria(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get verifyCodeTimerExpired => GoogleFonts.alexandria(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.submittingText,
      );

  static TextStyle get verifyErrorMessage => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.errorRed,
        height: 1.33,
      );

  static TextStyle get verifyGuidance => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.submittingText,
        height: 1.33,
      );

  static TextStyle get resendNoticeText => GoogleFonts.alexandria(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryBlue,
        height: 1.33,
      );

  static TextStyle get resendCooldownText => GoogleFonts.alexandria(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.submittingText,
      );

  // Done / Verified Screen (Figma Frame 1:897)
  static TextStyle get verifiedTitle => GoogleFonts.alexandria(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnboardingDark,
      );

  static TextStyle get verifiedSubtitle => GoogleFonts.alexandria(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.textOnboardingDark,
        height: 1.5,
      );
}
