import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'widgets/invalid_credentials_notice.dart';
import 'widgets/login_footer_section.dart';
import 'widgets/login_form_section.dart';
import 'widgets/login_header_section.dart';
import 'widgets/or_divider_section.dart';
import 'widgets/social_auth_section.dart';

/// Full-screen Login View reproducing Figma Frame 1:820 ("log in").
/// Also handles the Submitting state (Frame 1:908) and Invalid Credentials state (Frame 1:954).
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nationalIdController;
  late final TextEditingController _emailOrMobileController;
  late final TextEditingController _passwordController;

  bool _isLoading = false;
  bool _hasAuthError = false;

  @override
  void initState() {
    super.initState();
    _nationalIdController = TextEditingController();
    _emailOrMobileController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    _emailOrMobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _hasAuthError = false;
      });

      final email = _emailOrMobileController.text.trim().toLowerCase();
      final password = _passwordController.text;
      final nationalId = _nationalIdController.text.trim();

      // Check for intentional test invalid credentials trigger
      final bool isFailure = email == 'fail@gmail.com' ||
          password == 'Wrong123!' ||
          nationalId == '11111111111111';

      // Simulated network authentication delay
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        if (isFailure) {
          setState(() {
            _isLoading = false;
            _hasAuthError = true;
          });
        } else {
          setState(() {
            _isLoading = false;
            _hasAuthError = false;
          });
          // Navigates to the next page ("verify code" screen)
          context.push(AppRoutes.verifyCode);
        }
      });
    }
  }

  void _onForgotPasswordPressed() {
    context.push(AppRoutes.forgotPassword);
  }

  void _onRegisterPressed() {
    context.push(AppRoutes.register);
  }

  void _onSocialPressed(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Continue with $provider')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),

                  // 1. Header (Welcome back & subtitle)
                  const LoginHeaderSection(),

                  const SizedBox(height: 24),

                  // 2. Input Fields (National Id, Email, Password, Forgot Password)
                  // Wrapped with soft blur & 0.6 opacity during submission (Figma Frame 1:908 - Node 1:915 "Busy form")
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: _isLoading ? 1.5 : 0.0,
                      sigmaY: _isLoading ? 1.5 : 0.0,
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _isLoading ? 0.6 : 1.0,
                      child: LoginFormSection(
                        nationalIdController: _nationalIdController,
                        emailOrMobileController: _emailOrMobileController,
                        passwordController: _passwordController,
                        onForgotPasswordPressed: _onForgotPasswordPressed,
                        isSubmitting: _isLoading,
                        onInputChanged: () {
                          if (_hasAuthError) {
                            setState(() {
                              _hasAuthError = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  // Guidance message during submission (Figma Frame 1:908 - Node 1:937 "Guidance")
                  if (_isLoading) ...[
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        AppStrings.signingInGuidance,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.submittingGuidance,
                      ),
                    ),
                  ],

                  // State Notice: Invalid credentials banner (Figma Frame 1:954)
                  if (_hasAuthError) ...[
                    const SizedBox(height: 16),
                    const InvalidCredentialsNotice(),
                  ],

                  const SizedBox(height: 20),

                  // 3 & 4. "or" Divider & Social Auth Buttons (Figma Frame 1:908 - Node 1:938 "Other sign in options", opacity 0.38)
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: _isLoading ? 1.5 : 0.0,
                      sigmaY: _isLoading ? 1.5 : 0.0,
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _isLoading ? 0.38 : 1.0,
                      child: Column(
                        children: [
                          const OrDividerSection(),
                          const SizedBox(height: 20),
                          SocialAuthSection(
                            onApplePressed: _isLoading ? () {} : () => _onSocialPressed('Apple'),
                            onFacebookPressed: _isLoading ? () {} : () => _onSocialPressed('Facebook'),
                            onGooglePressed: _isLoading ? () {} : () => _onSocialPressed('Google'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 5. Submit Action & Register Link
                  LoginFooterSection(
                    onLoginPressed: _onLoginPressed,
                    onRegisterPressed: _onRegisterPressed,
                    isLoading: _isLoading,
                    hasAuthError: _hasAuthError,
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
