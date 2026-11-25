import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Top bar for onboarding displaying optional Back and Skip buttons.
/// Screen 1: Skip only
/// Screen 2: Back and Skip
/// Screen 3: Back only
class OnboardingTopBar extends StatelessWidget {
  final bool canGoBack;
  final bool showSkip;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSkipPressed;

  const OnboardingTopBar({
    super.key,
    required this.canGoBack,
    required this.showSkip,
    this.onBackPressed,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            if (canGoBack)
              IconButton(
                onPressed: onBackPressed,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textOnboardingDark,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                tooltip: 'Back',
              )
            else
              const SizedBox(width: 44, height: 44),

            // Skip button
            if (showSkip)
              TextButton(
                onPressed: onSkipPressed,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(44, 44),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppStrings.skip,
                  style: AppTextStyles.onboardingSkip,
                ),
              )
            else
              const SizedBox(width: 44, height: 44),
          ],
        ),
      ),
    );
  }
}
