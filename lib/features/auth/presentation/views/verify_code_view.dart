import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// Verify Code (OTP) view reproducing Figma Frame 1:876 ("verify code") exactly:
/// - Starts directly from the top of the screen (Figma Frame 126: x=16, y=87, w=361, h=341)
/// - NO back arrow or back button (matching Figma Frame 1:876)
/// - Exact 55x55 boxes with 14dp corner radius and #00000E border
/// - 1-minute countdown timer (starting at 00:59, counting down second-by-second)
/// - "verify" button and "Didn’t receive the code? Resend" link
class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  Timer? _timer;
  int _remainingSeconds = 59; // 1 minute countdown (00:59 down to 00:00)

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onVerifyPressed() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 5 digits.')),
      );
      return;
    }

    // Navigate to Done / Verified screen (Figma Frame 1:897)
    context.push(AppRoutes.authDone);
  }

  void _onResendPressed() {
    setState(() {
      _remainingSeconds = 59;
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusNodes[0].requestFocus();
    _startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification code resent.')),
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
            // Figma Frame 126 starts at y=87 (25dp below status bar y=62), x=16
            padding: const EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Frame 124: Header (Title & Subtitle) - height 48
                Text(
                  AppStrings.verifyCodeTitle,
                  style: AppTextStyles.loginTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.verifyCodeSubtitle,
                  style: AppTextStyles.loginSubtitle,
                ),

                // Spacing between Header and Code Inputs: 48dp (Figma Frame 126 itemSpacing: 48)
                const SizedBox(height: 48),

                // Frame 122: 5-digit OTP Code inputs (55x55 each, cornerRadius: 14, stroke: #00000E)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return SizedBox(
                      width: 55,
                      height: 55,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        cursorColor: AppColors.submittingText,
                        cursorWidth: 1.5,
                        style: AppTextStyles.verifyCodeTimer,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: AppColors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.textOnboardingDark,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.primaryBlue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 4) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                // Spacing between Code Inputs and Timer: 24dp (Figma Frame 123 itemSpacing: 24)
                const SizedBox(height: 24),

                // Node 1:890: Countdown Timer (fontSize: 24, Bold 700, #00000E)
                Center(
                  child: Text(
                    _formattedTime,
                    style: AppTextStyles.verifyCodeTimer,
                  ),
                ),

                // Spacing between Timer and Action Button: 48dp (Figma Frame 126 itemSpacing: 48)
                const SizedBox(height: 48),

                // Frame 125: Verify Button (361x56, radius: 40, #047DF2)
                CustomButton(
                  text: AppStrings.verify,
                  onPressed: _onVerifyPressed,
                  height: 56.0,
                  borderRadius: 40.0,
                  backgroundColor: AppColors.primaryBlue,
                  textColor: AppColors.white,
                ),

                // Spacing between Button and Resend link: 16dp (Figma Frame 125 itemSpacing: 16)
                const SizedBox(height: 16),

                // Frame 15: "Didn’t receive the code? Resend" link (250x24 in Figma)
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${AppStrings.didntReceiveCode} ',
                      style: AppTextStyles.dontHaveAccountText,
                    ),
                    GestureDetector(
                      onTap: _onResendPressed,
                      child: Text(
                        AppStrings.resend,
                        style: AppTextStyles.registerLink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
