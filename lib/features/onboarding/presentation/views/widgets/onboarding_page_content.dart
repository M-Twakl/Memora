import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/features/onboarding/data/models/onboarding_item_model.dart';
import 'package:memora/features/onboarding/presentation/views/widgets/onboarding_step_illustration.dart';
import 'package:memora/shared/widgets/page_indicator_dots.dart';

/// Displays the exact vector illustration with wave and icons, indicator dots, title, and subtitle.
/// The illustration extends edge-to-edge with ZERO horizontal padding to match the Figma design,
/// while all illustration elements animate continuously with independent floating movements.
class OnboardingPageContent extends StatelessWidget {
  final OnboardingItemModel item;
  final int currentIndex;
  final int totalCount;

  const OnboardingPageContent({
    super.key,
    required this.item,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: availableHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Edge-to-edge animated vector illustration with ZERO padding
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 393 / 470,
                      child: OnboardingStepIllustration(
                        stepIndex: item.stepIndex,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Indicator Dots
                  PageIndicatorDots(
                    count: totalCount,
                    currentIndex: currentIndex,
                    dotSize: 8.0,
                    spacing: 4.0,
                  ),

                  const SizedBox(height: 18),

                  // Title (with comfortable horizontal padding for readable typography)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      item.title,
                      style: AppTextStyles.onboardingTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Subtitle (with comfortable horizontal padding)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      item.subtitle,
                      style: AppTextStyles.onboardingSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
