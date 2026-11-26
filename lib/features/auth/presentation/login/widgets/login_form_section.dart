import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/core/utils/validators.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

/// Form fields section for the login screen:
/// 1. National Id (with identity card icon)
/// 2. Email or Mobile Number (with mail icon)
/// 3. Password (with lock icon, visibility toggle, and forgot password link)
class LoginFormSection extends StatefulWidget {
  final TextEditingController nationalIdController;
  final TextEditingController emailOrMobileController;
  final TextEditingController passwordController;
  final VoidCallback onForgotPasswordPressed;
  final bool isSubmitting;
  final VoidCallback? onInputChanged;

  const LoginFormSection({
    super.key,
    required this.nationalIdController,
    required this.emailOrMobileController,
    required this.passwordController,
    required this.onForgotPasswordPressed,
    this.isSubmitting = false,
    this.onInputChanged,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. National Id
        CustomTextField(
          label: AppStrings.nationalId,
          hintText: AppStrings.nationalIdHint,
          controller: widget.nationalIdController,
          leadingSvgAsset: AppAssets.icIdCard,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          enabled: !widget.isSubmitting,
          onChanged: (_) => widget.onInputChanged?.call(),
          validator: AppValidators.validateNationalId,
        ),

        const SizedBox(height: 16),

        // 2. Email or Mobile Number
        CustomTextField(
          label: AppStrings.emailOrMobile,
          hintText: AppStrings.emailPlaceholder,
          controller: widget.emailOrMobileController,
          leadingSvgAsset: AppAssets.icMail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          enabled: !widget.isSubmitting,
          onChanged: (_) => widget.onInputChanged?.call(),
          validator: AppValidators.validateEmailOrPhone,
        ),

        const SizedBox(height: 16),

        // 3. Password
        CustomTextField(
          label: AppStrings.password,
          hintText: AppStrings.passwordPlaceholder,
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          leadingSvgAsset: AppAssets.icLock,
          textInputAction: TextInputAction.done,
          enabled: !widget.isSubmitting,
          onChanged: (_) => widget.onInputChanged?.call(),
          trailingIcon: GestureDetector(
            onTap: widget.isSubmitting
                ? null
                : () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
            child: SvgPicture.asset(
              AppAssets.icEye,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                _obscurePassword ? AppColors.inputIcon : AppColors.primaryBlue,
                BlendMode.srcIn,
              ),
            ),
          ),
          validator: AppValidators.validatePassword,
        ),

        const SizedBox(height: 8),

        // Forgot Password link (aligned to the right)
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: widget.isSubmitting ? null : widget.onForgotPasswordPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppStrings.forgotPassword,
              style: widget.isSubmitting
                  ? AppTextStyles.forgotPassword.copyWith(color: AppColors.submittingText)
                  : AppTextStyles.forgotPassword,
            ),
          ),
        ),
      ],
    );
  }
}
