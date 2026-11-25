import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Top header section for the login screen.
/// Displays "Welcome back" and subtitle matching Figma Frame 20 (1:822).
class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.welcomeBack,
          style: AppTextStyles.loginTitle,
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.signInSubtitle,
          style: AppTextStyles.loginSubtitle,
        ),
      ],
    );
  }
}
