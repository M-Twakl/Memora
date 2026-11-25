import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Action buttons for the Welcome / Gateway screen: "log in" and "register".
/// Matches Frame 12 (1:798) in Figma with 40px rounded corners and primary blue accents.
class WelcomeActionsSection extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const WelcomeActionsSection({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary filled button: "log in" (1:799)
        CustomButton(
          text: AppStrings.logIn,
          onPressed: onLoginPressed,
          height: 56.0,
          borderRadius: 40.0,
          backgroundColor: AppColors.primaryBlue,
          textColor: AppColors.white,
        ),

        const SizedBox(height: 16),

        // Secondary outlined button: "register" (1:800)
        CustomButton(
          text: AppStrings.register,
          onPressed: onRegisterPressed,
          height: 56.0,
          borderRadius: 40.0,
          backgroundColor: Colors.transparent,
          textColor: AppColors.primaryBlue,
          border: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.5,
          ),
        ),
      ],
    );
  }
}
