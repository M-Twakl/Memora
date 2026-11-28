import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Footer section for the registration screen matching Figma Frame 1:1246 & 1:1704.
/// Contains the primary "continue" action button and "Have an account? Log In" link.
class RegisterFooterSection extends StatelessWidget {
  final VoidCallback onContinuePressed;
  final VoidCallback onLogInPressed;
  final bool isLoading;
  final bool isButtonEnabled;

  const RegisterFooterSection({
    super.key,
    required this.onContinuePressed,
    required this.onLogInPressed,
    this.isLoading = false,
    this.isButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary action button: "continue" (Figma Frame 1:1247)
        CustomButton(
          text: AppStrings.continueButton,
          onPressed: isButtonEnabled && !isLoading ? onContinuePressed : () {},
          isLoading: isLoading,
          height: 56.0,
          borderRadius: 40.0,
          backgroundColor: isButtonEnabled
              ? AppColors.primaryBlue
              : AppColors.disabledButton,
          textColor: isButtonEnabled
              ? AppColors.white
              : AppColors.submittingText,
        ),

        const SizedBox(height: 16),

        // "Have an account? Log In" path (Figma Frame 1:1248 & 1:1705)
        Center(
          child: Text.rich(
            TextSpan(
              text: '${AppStrings.haveAnAccount} ',
              style: isLoading
                  ? AppTextStyles.dontHaveAccountText
                      .copyWith(color: AppColors.submittingText)
                  : AppTextStyles.dontHaveAccountText,
              children: [
                TextSpan(
                  text: AppStrings.logInLink,
                  style: isLoading
                      ? AppTextStyles.registerLink
                          .copyWith(color: AppColors.submittingText)
                      : AppTextStyles.registerLink,
                  recognizer: TapGestureRecognizer()
                    ..onTap = isLoading ? null : onLogInPressed,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
