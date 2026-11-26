import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'package:memora/shared/widgets/custom_button.dart';

/// States for the Verify Code screen matching Figma design:
/// - [normal]: Initial active countdown from 00:59, normal black boxes, "verify" button (Frame 1:876 / 1:1064)
/// - [incorrect]: Code mismatch, red boxes, error text, guidance, "Try Again" button (Frame 1:1099)
/// - [expired]: Timer reached 00:00, grey boxes, error text, guidance, disabled "Verify" button (Frame 1:1037)
/// - [resendCooldown]: Code resent, light blue dynamic notice banner, cleared boxes, 1-minute countdown timer on Resend button, guidance below Resend (Frame 1:1126)
enum VerifyCodeStatus {
  normal,
  incorrect,
  expired,
  resendCooldown,
}

/// Verify Code view reproducing Figma Frames 1:876, 1:1064, 1:1099, 1:1037, 1:1126.
class VerifyCodeView extends StatefulWidget {
  final VerifyCodeStatus initialStatus;
  final VoidCallback? onVerified;

  const VerifyCodeView({
    super.key,
    this.initialStatus = VerifyCodeStatus.normal,
    this.onVerified,
  });

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  late VerifyCodeStatus _status;
  Timer? _timer;
  int _remainingSeconds = 59; // 1-minute countdown (00:59 down to 00:00)

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;

    if (_status == VerifyCodeStatus.expired) {
      _remainingSeconds = 0;
      // Pre-fill digits as shown in Figma Frame 1:1037 (4 8 2 1 6)
      const digits = ['4', '8', '2', '1', '6'];
      for (int i = 0; i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
    } else if (_status == VerifyCodeStatus.incorrect) {
      _remainingSeconds = 42;
      const digits = ['4', '8', '2', '1', '6'];
      for (int i = 0; i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      _startTimer();
    } else if (_status == VerifyCodeStatus.resendCooldown) {
      _remainingSeconds = 59; // 1-minute cooldown
      _startTimer();
    } else {
      _startTimer();
    }
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
        if (mounted && _status != VerifyCodeStatus.expired) {
          setState(() {
            _status = VerifyCodeStatus.expired;
          });
        }
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get _isAllDigitsEntered =>
      _controllers.every((c) => c.text.trim().isNotEmpty);

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

    // If code is "48216" or anything other than "11111", simulate incorrect code (Frame 1:1099)
    if (code != '11111' && (code == '48216' || code == '12345')) {
      setState(() {
        _status = VerifyCodeStatus.incorrect;
      });
      return;
    }

    // Success navigation
    if (widget.onVerified != null) {
      widget.onVerified!();
    } else {
      context.push(AppRoutes.authDone);
    }
  }

  void _onTryAgainPressed() {
    setState(() {
      _status = VerifyCodeStatus.normal;
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusNodes[0].requestFocus();
  }

  void _onResendPressed() {
    // Only allow resend if not currently in cooldown
    if (_status == VerifyCodeStatus.resendCooldown && _remainingSeconds > 0) {
      return;
    }

    setState(() {
      _status = VerifyCodeStatus.resendCooldown;
      _remainingSeconds = 59; // Reset to full 1 minute (00:59)
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusNodes[0].requestFocus();
    _startTimer();
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
            // Figma Frame 126 / Content starts at y=87 (25dp below status bar y=62), x=16
            padding: const EdgeInsets.only(
              top: 25.0,
              left: 16.0,
              right: 16.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Introduction Header (Title & Subtitle) - height 50
                Text(
                  AppStrings.verifyCodeTitle,
                  style: AppTextStyles.loginTitle,
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.verifyCodeSubtitle,
                  style: AppTextStyles.loginSubtitle,
                ),

                const SizedBox(height: 48),

                // 2. Dynamic State Notice Banner (Figma Frame 1:1126 - Resend Cooldown)
                // Appears smoothly on the same screen when a new code is sent
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _status == VerifyCodeStatus.resendCooldown
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: AppColors.infoBackground,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icInfoCircle,
                                  width: 18,
                                  height: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    AppStrings.newCodeSentNotice,
                                    style: AppTextStyles.resendNoticeText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // 3. Five-Digit Code Input Boxes (55x55, 14dp radius)
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
                        enabled: _status != VerifyCodeStatus.expired,
                        cursorColor: AppColors.submittingText,
                        cursorWidth: 1.5,
                        style: _status == VerifyCodeStatus.expired
                            ? AppTextStyles.verifyCodeTimerExpired
                            : AppTextStyles.verifyCodeTimer,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: AppColors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: _getBorderColor(),
                              width: _status == VerifyCodeStatus.incorrect ? 1.5 : 1.0,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.inputBorder,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: _status == VerifyCodeStatus.incorrect
                                  ? AppColors.errorRed
                                  : AppColors.primaryBlue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (_status == VerifyCodeStatus.incorrect) {
                            setState(() {
                              _status = VerifyCodeStatus.normal;
                            });
                          } else {
                            setState(() {}); // refresh button enabled state
                          }
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

                // 4. Error Message (Figma Frames 1:1099 and 1:1037)
                if (_status == VerifyCodeStatus.incorrect) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.codeDoesNotMatch,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.verifyErrorMessage,
                    ),
                  ),
                ] else if (_status == VerifyCodeStatus.expired) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.codeExpiredMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.verifyErrorMessage,
                    ),
                  ),
                ],

                // Spacing to Timer
                const SizedBox(height: 16),

                // 5. Countdown Timer
                Center(
                  child: Text(
                    _status == VerifyCodeStatus.expired
                        ? AppStrings.timerZero
                        : _formattedTime,
                    style: _status == VerifyCodeStatus.expired
                        ? AppTextStyles.verifyCodeTimerExpired
                        : AppTextStyles.verifyCodeTimer,
                  ),
                ),

                // 6. Guidance text below timer
                if (_status == VerifyCodeStatus.incorrect) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.codeExpiresGuidance,
                      style: AppTextStyles.verifyGuidance,
                    ),
                  ),
                ] else if (_status == VerifyCodeStatus.expired) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.codeExpiredGuidance,
                      style: AppTextStyles.verifyGuidance,
                    ),
                  ),
                ] else if (_status == VerifyCodeStatus.resendCooldown) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.enterNewCodeGuidance,
                      style: AppTextStyles.verifyGuidance,
                    ),
                  ),
                ],

                const SizedBox(height: 48),

                // 7. Primary Action Button (Frame 125 / Verification actions)
                _buildActionButton(),

                const SizedBox(height: 16),

                // 8. Resend Code Row
                _buildResendRow(),

                // 9. Resend Guidance below resend row (Frame 1:1126 - Node 1:1155)
                if (_status == VerifyCodeStatus.resendCooldown && _remainingSeconds > 0) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      AppStrings.resendCooldownGuidance,
                      style: AppTextStyles.verifyGuidance,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    switch (_status) {
      case VerifyCodeStatus.incorrect:
        return AppColors.errorRed;
      case VerifyCodeStatus.expired:
        return AppColors.inputBorder;
      case VerifyCodeStatus.normal:
      case VerifyCodeStatus.resendCooldown:
        return AppColors.textOnboardingDark;
    }
  }

  Widget _buildActionButton() {
    if (_status == VerifyCodeStatus.incorrect) {
      // Figma Frame 1:1099 Node 1:1121 "Try Again"
      return CustomButton(
        text: AppStrings.tryAgain,
        onPressed: _onTryAgainPressed,
        height: 56.0,
        borderRadius: 40.0,
        backgroundColor: AppColors.primaryBlue,
        textColor: AppColors.white,
      );
    }

    final bool isExpired = _status == VerifyCodeStatus.expired;
    final bool isCooldownIncomplete =
        _status == VerifyCodeStatus.resendCooldown && !_isAllDigitsEntered;
    final bool isDisabled = isExpired || isCooldownIncomplete;

    return CustomButton(
      text: AppStrings.verify,
      onPressed: isDisabled ? () {} : _onVerifyPressed,
      height: 56.0,
      borderRadius: 40.0,
      backgroundColor: isDisabled ? AppColors.disabledButton : AppColors.primaryBlue,
      textColor: isDisabled ? AppColors.submittingText : AppColors.white,
    );
  }

  Widget _buildResendRow() {
    final bool isCooldownActive =
        _status == VerifyCodeStatus.resendCooldown && _remainingSeconds > 0;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '${AppStrings.didntReceiveCode} ',
          style: AppTextStyles.dontHaveAccountText,
        ),
        if (isCooldownActive)
          Text(
            '${AppStrings.resend} (${_remainingSeconds}s)',
            style: AppTextStyles.resendCooldownText,
          )
        else
          GestureDetector(
            onTap: _onResendPressed,
            child: Text(
              AppStrings.resend,
              style: AppTextStyles.registerLink,
            ),
          ),
      ],
    );
  }
}
