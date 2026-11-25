import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Reusable primary action button with loading and disabled state support.
/// Sized at default 56dp height with fully rounded borders to match Figma design.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final Widget? icon;
  final BorderSide? border;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56.0,
    this.backgroundColor = AppColors.primaryBlue,
    this.textColor = AppColors.white,
    this.textStyle,
    this.borderRadius = 32.0,
    this.icon,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = (textStyle ?? AppTextStyles.button).copyWith(
      color: textColor,
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: effectiveTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
