import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_colors.dart';

/// Dot indicator displaying current page position with smooth animations.
class PageIndicatorDots extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;

  const PageIndicatorDots({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor = AppColors.dotActive,
    this.inactiveColor = AppColors.dotInactive,
    this.dotSize = 8.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
