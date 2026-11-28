import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import '../../shared/widgets/or_divider_section.dart';
import '../../shared/widgets/social_auth_section.dart';
import '../widgets/register_footer_section.dart';
import '../widgets/register_form_section.dart';
import '../widgets/register_header_section.dart';

/// Full-screen Register View reproducing Figma Frame 1:1184 ("registeration")
/// and Frame 1:1650 (" Required fields").
class RegisterView extends StatefulWidget {
  final VoidCallback? onRegistered;

  const RegisterView({
    super.key,
    this.onRegistered,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _nationalIdController;
  late final TextEditingController _emailOrMobileController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isLoading = false;
  bool _hasValidationErrors = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _nationalIdController = TextEditingController();
    _emailOrMobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nationalIdController.dispose();
    _emailOrMobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    if (_hasValidationErrors) {
      setState(() {
        _hasValidationErrors = false;
      });
    }
  }

  void _onContinuePressed() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _hasValidationErrors = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasValidationErrors = false;
    });

    // Simulate registration submission delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      if (widget.onRegistered != null) {
        widget.onRegistered!();
      } else {
        context.push(AppRoutes.persona);
      }
    });
  }

  void _onLogInPressed() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.pushReplacement(AppRoutes.login);
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
            padding: const EdgeInsets.only(
              top: 25.0,
              left: 16.0,
              right: 16.0,
              bottom: 24.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Header & Dynamic Validation Error Notice
                  RegisterHeaderSection(
                    hasValidationErrors: _hasValidationErrors,
                  ),

                  const SizedBox(height: 24),

                  // 2. Form Fields (Full Name, National ID, Email/Mobile, Password, Confirm)
                  RegisterFormSection(
                    fullNameController: _fullNameController,
                    nationalIdController: _nationalIdController,
                    emailOrMobileController: _emailOrMobileController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onFieldChanged: _onFieldChanged,
                  ),

                  const SizedBox(height: 24),

                  // 3. Or Divider (Figma Frame 1:1232 & 1:1691)
                  const OrDividerSection(),

                  const SizedBox(height: 20),

                  // 4. Social Authentication Options (Apple, Facebook, Google)
                  SocialAuthSection(
                    onApplePressed: () {},
                    onFacebookPressed: () {},
                    onGooglePressed: () {},
                  ),

                  const SizedBox(height: 24),

                  // 5. Action Button & "Have an account? Log In" Footer
                  RegisterFooterSection(
                    onContinuePressed: _onContinuePressed,
                    onLogInPressed: _onLogInPressed,
                    isLoading: _isLoading,
                    isButtonEnabled: !_hasValidationErrors,
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
