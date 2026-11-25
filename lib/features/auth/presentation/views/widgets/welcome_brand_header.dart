import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Centered brand header displaying the Memora logo and tagline.
/// Replicates Frame 11 (1:802) in the Figma "have an account" screen.
class WelcomeBrandHeader extends StatelessWidget {
  const WelcomeBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand logo (Frame 1171275577)
        SvgPicture.asset(
          AppAssets.memoraLogo,
          width: 100,
          height: 100,
          alignment: Alignment.center,
        ),

        const SizedBox(height: 16),

        // Tagline (1:819)
        Text(
          AppStrings.authTagline,
          style: AppTextStyles.welcomeTagline,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
