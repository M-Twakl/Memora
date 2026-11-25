import 'package:flutter/material.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// "or" divider line with a centered pill label.
/// Matches Figma Group "or" (1:856).
class OrDividerSection extends StatelessWidget {
  const OrDividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.dividerLine,
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.orDivider,
            style: AppTextStyles.orDividerText,
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.dividerLine,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
