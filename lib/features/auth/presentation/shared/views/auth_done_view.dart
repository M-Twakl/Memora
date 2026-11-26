import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Done / Verified Screen reproducing Figma Frame 1:897 ("done"):
/// - 114x114 circular check badge with 8px stroke (#047DF2 on #00A2FF 23% opacity)
/// - "Verified !" title in Alexandria Bold 700 20sp
/// - "Your account has been verified. You’re all set to continue." subtitle in Alexandria Light 300 16sp
/// - Primary "Done" action button at the bottom
class AuthDoneView extends StatelessWidget {
  final VoidCallback? onDonePressed;

  const AuthDoneView({
    super.key,
    this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),

                // Circle Checkmark Badge (Figma Node 1:900 - 114x114)
                Center(
                  child: SvgPicture.asset(
                    AppAssets.icVerifiedBadge,
                    width: 114,
                    height: 114,
                  ),
                ),

                const SizedBox(height: 32),

                // Title (Figma Node 1:904)
                Text(
                  AppStrings.verifiedTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.verifiedTitle,
                ),

                const SizedBox(height: 8),

                // Subtitle (Figma Node 1:905)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    AppStrings.verifiedSubtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.verifiedSubtitle,
                  ),
                ),

                const Spacer(flex: 5),

                // Primary Done Button (Figma Node 1:906)
                CustomButton(
                  text: AppStrings.done,
                  onPressed: onDonePressed ?? () => context.go(AppRoutes.splash),
                  height: 56.0,
                  borderRadius: 40.0,
                  backgroundColor: AppColors.primaryBlue,
                  textColor: AppColors.white,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
