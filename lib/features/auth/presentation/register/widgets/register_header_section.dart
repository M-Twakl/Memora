import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Header section for the registration screen matching Figma Frame 1:1186 & 1:1652.
/// Displays the title "Create your account" and an animated error banner when validation fails.
class RegisterHeaderSection extends StatelessWidget {
  final bool hasValidationErrors;

  const RegisterHeaderSection({
    super.key,
    this.hasValidationErrors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createYourAccount,
          style: AppTextStyles.loginTitle,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: hasValidationErrors
              ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    AppStrings.requiredFieldsNotice,
                    style: AppTextStyles.registrationErrorBanner,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
