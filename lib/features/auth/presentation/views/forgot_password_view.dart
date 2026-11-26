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

/// Forgot Password screen reproducing Figma Frame 1:1085 ("Forgot pass"):
/// - Starts directly from the top of the screen (Frame 128: x=16, y=92, w=366, h=274)
/// - Title: "forgot password" (Alexandria Bold 700 20sp)
/// - Subtitle: "We need your E-mail so we can send you the password reset code." (Alexandria Light 300 12sp)
/// - Input: "Email or mobile number" with ic_mail leading icon and validation
/// - Action: "send code" button (361x56, radius 40, #047DF2)
class ForgotPasswordView extends StatefulWidget {
  final VoidCallback? onCodeSent;

  const ForgotPasswordView({
    super.key,
    this.onCodeSent,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrMobileController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailOrMobileController.dispose();
    super.dispose();
  }

  void _onSendCodePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulated network code dispatch
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        // Navigate to the next screen in the forgot password flow (verify code)
        if (widget.onCodeSent != null) {
          widget.onCodeSent!();
        } else {
          context.push('${AppRoutes.verifyCode}?from=forgot');
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
            // Frame 128 starts at y=92 (30dp below status bar y=62), x=16
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
                  // Frame 127: Header (Title & Subtitle) - height 64
                  Text(
                    AppStrings.forgotPasswordTitle,
                    style: AppTextStyles.loginTitle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.forgotPasswordSubtitle,
                    style: AppTextStyles.loginSubtitle,
                  ),

                  // Spacing: 32dp (Figma Frame 128 itemSpacing: 32)
                  const SizedBox(height: 32),

                  // Frame 1091: Email or mobile number field (height 90, itemSpacing: 6)
                  CustomTextField(
                    label: AppStrings.emailOrMobile,
                    hintText: AppStrings.emailPlaceholder,
                    controller: _emailOrMobileController,
                    keyboardType: TextInputType.emailAddress,
                    leadingSvgAsset: AppAssets.icMail,
                    validator: AppValidators.validateEmailOrPhone,
                    enabled: !_isLoading,
                  ),

                  // Spacing: 32dp (Figma Frame 128 itemSpacing: 32)
                  const SizedBox(height: 32),

                  // Frame 1098: Send Code main button (361x56, radius 40, #047DF2)
                  CustomButton(
                    text: AppStrings.sendCode,
                    onPressed: _isLoading ? () {} : _onSendCodePressed,
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
