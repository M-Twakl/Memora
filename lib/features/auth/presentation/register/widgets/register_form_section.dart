import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/utils/validators.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

/// Form section for user registration matching Figma Frame 1:1187 & 1:1655.
/// Contains Full Name, National ID, Email or Mobile, Password, and Confirm Password fields.
class RegisterFormSection extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController nationalIdController;
  final TextEditingController emailOrMobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback? onFieldChanged;

  const RegisterFormSection({
    super.key,
    required this.fullNameController,
    required this.nationalIdController,
    required this.emailOrMobileController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.onFieldChanged,
  });

  @override
  State<RegisterFormSection> createState() => _RegisterFormSectionState();
}

class _RegisterFormSectionState extends State<RegisterFormSection> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Full Name (Figma Frame 1:1188)
        CustomTextField(
          label: AppStrings.fullName,
          hintText: AppStrings.fullName,
          controller: widget.fullNameController,
          validator: AppValidators.validateFullName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (_) => widget.onFieldChanged?.call(),
        ),

        const SizedBox(height: 16),

        // 2. National ID (Figma Frame 1:1192)
        CustomTextField(
          label: AppStrings.nationalId,
          hintText: AppStrings.nationalIdHint,
          leadingSvgAsset: AppAssets.icIdCard,
          controller: widget.nationalIdController,
          validator: AppValidators.validateNationalId,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onChanged: (_) => widget.onFieldChanged?.call(),
        ),

        const SizedBox(height: 16),

        // 3. Email or Mobile Number (Figma Frame 1:1201)
        CustomTextField(
          label: AppStrings.emailOrMobile,
          hintText: AppStrings.emailPlaceholder,
          leadingSvgAsset: AppAssets.icMail,
          controller: widget.emailOrMobileController,
          validator: AppValidators.validateEmailOrPhone,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (_) => widget.onFieldChanged?.call(),
        ),

        const SizedBox(height: 16),

        // 4. Password (Figma Frame 1:1208)
        CustomTextField(
          label: AppStrings.password,
          hintText: AppStrings.passwordMinLengthPlaceholder,
          leadingSvgAsset: AppAssets.icLock,
          controller: widget.passwordController,
          validator: AppValidators.validateNewPassword,
          obscureText: _obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          trailingIcon: IconButton(
            icon: SvgPicture.asset(
              AppAssets.icEye,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                _obscurePassword
                    ? const Color(0xFF6B7280)
                    : const Color(0xFF0088FF),
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          onChanged: (_) => widget.onFieldChanged?.call(),
        ),

        const SizedBox(height: 16),

        // 5. Confirm Password (Figma Frame 1:1220)
        CustomTextField(
          label: AppStrings.confirmPassword,
          hintText: AppStrings.passwordMinLengthPlaceholder,
          leadingSvgAsset: AppAssets.icLock,
          controller: widget.confirmPasswordController,
          validator: (value) => AppValidators.validateConfirmPassword(
            value,
            widget.passwordController.text,
          ),
          obscureText: _obscureConfirmPassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          trailingIcon: IconButton(
            icon: SvgPicture.asset(
              AppAssets.icEye,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                _obscureConfirmPassword
                    ? const Color(0xFF6B7280)
                    : const Color(0xFF0088FF),
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
          onChanged: (_) => widget.onFieldChanged?.call(),
        ),
      ],
    );
  }
}
