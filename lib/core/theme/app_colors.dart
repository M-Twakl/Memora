import 'package:flutter/material.dart';

/// Centralized application color palette extracted directly from design system.
abstract class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF047DF2);
  static const Color darkBlue = Color(0xFF0347C4);
  static const Color lightBlue = Color(0xFF81BEF9);
  static const Color accentPink = Color(0xFFD20B68);

  // Backgrounds & Surface
  static const Color splashBackground = Color(0xFFFEFEFE);
  static const Color scaffoldBackground = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Neutral & Text Palette
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Onboarding Specific Palette
  static const Color textOnboardingDark = Color(0xFF00000E);
  static const Color textSkip = Color(0x8000000E);
  static const Color dotInactive = Color(0xFFB0B2B2);
  static const Color dotActive = Color(0xFF047DF2);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Auth Form Palette
  static const Color inputBorder = Color(0xFFD9D9D9);
  static const Color inputHint = Color(0xFFB0B2B2);
  static const Color inputIcon = Color(0xFFB0B2B2);
  static const Color socialButtonBackground = Color(0xFFFBFBFB);
  static const Color dividerLine = Color(0xFFB0B2B2);

  // Auth Notices & States (Figma Frames 1:908 & 1:954)
  static const Color errorRed = Color(0xFFD22B2B);
  static const Color errorBackground = Color(0xFFFFF4F3);
  static const Color submittingText = Color(0xFF828282);
}
