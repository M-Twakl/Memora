import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Bottom action area of the onboarding flow containing the Next/Get Started button.
class OnboardingBottomSection extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onButtonPressed;

  const OnboardingBottomSection({
    super.key,
    required this.isLastPage,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: CustomButton(
        text: isLastPage ? AppStrings.getStarted : AppStrings.next,
        onPressed: onButtonPressed,
        height: 56.0,
        borderRadius: 32.0,
      ),
    );
  }
}
