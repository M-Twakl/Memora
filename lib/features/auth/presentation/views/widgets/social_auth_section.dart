import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Social authentication buttons for Apple, Facebook, and Google.
/// Matches Figma Frame 19 (1:860) with 52dp height, 40dp radius, and #FBFBFB background.
class SocialAuthSection extends StatelessWidget {
  final VoidCallback onApplePressed;
  final VoidCallback onFacebookPressed;
  final VoidCallback onGooglePressed;

  const SocialAuthSection({
    super.key,
    required this.onApplePressed,
    required this.onFacebookPressed,
    required this.onGooglePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          iconAsset: AppAssets.icApple,
          text: AppStrings.continueWithApple,
          onPressed: onApplePressed,
        ),
        const SizedBox(height: 8),
        _buildSocialButton(
          iconAsset: AppAssets.icFacebook,
          text: AppStrings.continueWithFacebook,
          onPressed: onFacebookPressed,
        ),
        const SizedBox(height: 8),
        _buildSocialButton(
          iconAsset: AppAssets.icGoogle,
          text: AppStrings.continueWithGoogle,
          onPressed: onGooglePressed,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String iconAsset,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socialButtonBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.socialButtonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 24), // Balance leading icon width for perfect centering
          ],
        ),
      ),
    );
  }
}
