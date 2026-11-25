import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Footer section for the login screen:
/// 1. Primary "log in" submit button
/// 2. "Don’t have an account? Register" inline link
class LoginFooterSection extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final bool isLoading;
  final bool hasAuthError;

  const LoginFooterSection({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    this.isLoading = false,
    this.hasAuthError = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = hasAuthError
        ? AppStrings.tryAgain
        : (isLoading ? AppStrings.logInSubmitting : AppStrings.logIn);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main submit button
        CustomButton(
          text: buttonText,
          onPressed: onLoginPressed,
          isLoading: isLoading,
          height: 56.0,
          borderRadius: 40.0,
          backgroundColor: AppColors.primaryBlue,
          textColor: AppColors.white,
        ),

        const SizedBox(height: 16),

        // Don’t have an account? Register link
        Center(
          child: Text.rich(
            TextSpan(
              text: '${AppStrings.dontHaveAccount} ',
              style: isLoading
                  ? AppTextStyles.dontHaveAccountText
                      .copyWith(color: AppColors.submittingText)
                  : AppTextStyles.dontHaveAccountText,
              children: [
                TextSpan(
                  text: AppStrings.registerLink,
                  style: isLoading
                      ? AppTextStyles.registerLink
                          .copyWith(color: AppColors.submittingText)
                      : AppTextStyles.registerLink,
                  recognizer: TapGestureRecognizer()
                    ..onTap = isLoading ? null : onRegisterPressed,
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
