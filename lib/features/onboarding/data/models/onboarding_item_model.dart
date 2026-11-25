import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';

/// Data model representing an onboarding step with its exact SVG illustration.
class OnboardingItemModel {
  final int stepIndex;
  final String title;
  final String subtitle;
  final String svgAsset;

  const OnboardingItemModel({
    required this.stepIndex,
    required this.title,
    required this.subtitle,
    required this.svgAsset,
  });

  static const List<OnboardingItemModel> items = [
    OnboardingItemModel(
      stepIndex: 0,
      title: AppStrings.onboardingTitle1,
      subtitle: AppStrings.onboardingSubtitle1,
      svgAsset: AppAssets.onboardingIllustration1,
    ),
    OnboardingItemModel(
      stepIndex: 1,
      title: AppStrings.onboardingTitle2,
      subtitle: AppStrings.onboardingSubtitle2,
      svgAsset: AppAssets.onboardingIllustration2,
    ),
    OnboardingItemModel(
      stepIndex: 2,
      title: AppStrings.onboardingTitle3,
      subtitle: AppStrings.onboardingSubtitle3,
      svgAsset: AppAssets.onboardingIllustration3,
    ),
  ];
}
