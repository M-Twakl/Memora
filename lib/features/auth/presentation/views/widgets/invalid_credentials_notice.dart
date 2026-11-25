import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Error state notice banner reproducing Figma Frame 1:981 ("State notice").
/// Displayed when user credentials fail verification.
class InvalidCredentialsNotice extends StatelessWidget {
  const InvalidCredentialsNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.icCircleAlert,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.errorRed,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppStrings.invalidCredentialsNotice,
              style: AppTextStyles.invalidCredentialsNotice,
            ),
          ),
        ],
      ),
    );
  }
}
