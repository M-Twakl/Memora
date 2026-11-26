import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/core/utils/validators.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

/// New Password view reproducing Figma Frames 1:1006 ("new pass") & 1:1157 ("Create password / Validation"):
/// - Starts directly from the top of the screen (Frame 131: x=16, y=92, w=361, h=48)
/// - Title: "create password" in Alexandria Bold 700 20sp
/// - Subtitle: "The password should have at least 6 characters ." in Alexandria Light 300 12sp
/// - Fields: "Password" and "Confirm Password" with lock icon, eye visibility toggle, and validation
/// - Action Button: "create new password" (361x56, radius 40, #047DF2)
class NewPasswordView extends StatefulWidget {
  final VoidCallback? onPasswordCreated;

  const NewPasswordView({
    super.key,
    this.onPasswordCreated,
  });

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreatePasswordPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulated network reset dispatch
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });

        if (widget.onPasswordCreated != null) {
          widget.onPasswordCreated!();
        } else {
          // Navigates to Done / Verified screen (Frame 1:897)
          context.push(AppRoutes.authDone);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // Figma Frame 131 starts at y=92 (30dp below status bar y=62), x=16
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 16.0,
              right: 16.0,
              bottom: 24.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Frame 131: Header (Title & Subtitle) - height 48
                  Text(
                    AppStrings.createPasswordTitle,
                    style: AppTextStyles.loginTitle,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.createPasswordSubtitle,
                    style: AppTextStyles.loginSubtitle,
                  ),

                  // Spacing between Header and Fields: 28dp
                  const SizedBox(height: 28),

                  // Frame 10: Password Field
                  CustomTextField(
                    label: AppStrings.password,
                    hintText: AppStrings.passwordPlaceholder,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    leadingSvgAsset: AppAssets.icLock,
                    trailingIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: AppColors.inputIcon,
                      ),
                    ),
                    validator: AppValidators.validateNewPassword,
                    enabled: !_isLoading,
                    onChanged: (_) {
                      if (_confirmPasswordController.text.isNotEmpty) {
                        _formKey.currentState?.validate();
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Frame 11: Confirm Password Field
                  CustomTextField(
                    label: AppStrings.confirmPassword,
                    hintText: AppStrings.passwordPlaceholder,
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    leadingSvgAsset: AppAssets.icLock,
                    trailingIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: AppColors.inputIcon,
                      ),
                    ),
                    validator: (value) => AppValidators.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    enabled: !_isLoading,
                  ),

                  // Spacing between Fields and Action Button: 38dp
                  const SizedBox(height: 38),

                  // Main Button: "create new password" (361x56, radius 40, #047DF2)
                  CustomButton(
                    text: AppStrings.createNewPassword,
                    onPressed: _isLoading ? () {} : _onCreatePasswordPressed,
                    isLoading: _isLoading,
                    height: 56.0,
                    borderRadius: 40.0,
                    backgroundColor: AppColors.primaryBlue,
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
