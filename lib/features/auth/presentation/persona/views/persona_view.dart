import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import '../widgets/persona_choice_card.dart';
import '../widgets/persona_header_section.dart';

/// Full-screen Persona selection view reproducing Figma Frame 1:1278 ("Persona").
/// Allows the user to select their role ("Patient" or "Doctor")
/// before proceeding to patient Q&A / medical onboarding.
class PersonaView extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final String? initialSelectedRole;

  const PersonaView({
    super.key,
    this.onNextPressed,
    this.initialSelectedRole,
  });

  @override
  State<PersonaView> createState() => _PersonaViewState();
}

class _PersonaViewState extends State<PersonaView> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialSelectedRole;
  }

  void _selectRole(String role) {
    setState(() {
      if (_selectedRole == role) {
        _selectedRole = null;
      } else {
        _selectedRole = role;
      }
    });
  }

  void _onNext() {
    if (_selectedRole == null) return;

    if (widget.onNextPressed != null) {
      widget.onNextPressed!();
    } else {
      // Future onboarding step (e.g. Patient Q&A)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selected role: $_selectedRole',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isNextEnabled = _selectedRole != null;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Back Navigation Button (Figma Frame 1:1285)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                if (context.canPop()) {
                                  context.pop();
                                }
                              },
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                width: 44,
                                height: 44,
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  AppAssets.icBack,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // 2. Header Title & Subtitle (Figma Frame 1:1282)
                          const PersonaHeaderSection(),

                          const SizedBox(height: 110),

                          // 3. Persona Role Choice Cards (Figma Frame 1:1287)
                          PersonaChoiceCard(
                            label: AppStrings.patientRole,
                            isSelected:
                                _selectedRole == AppStrings.patientRole,
                            onTap: () => _selectRole(AppStrings.patientRole),
                          ),

                          const SizedBox(height: 24),

                          PersonaChoiceCard(
                            label: AppStrings.doctorRole,
                            isSelected:
                                _selectedRole == AppStrings.doctorRole,
                            onTap: () => _selectRole(AppStrings.doctorRole),
                          ),

                          const Spacer(),

                          const SizedBox(height: 24),

                          // 4. Action Button: "next" (Figma Frame 1:1281)
                          CustomButton(
                            text: AppStrings.next,
                            onPressed: isNextEnabled ? _onNext : () {},
                            height: 56.0,
                            borderRadius: 40.0,
                            backgroundColor: isNextEnabled
                                ? AppColors.primaryBlue
                                : AppColors.disabledButton,
                            textColor: isNextEnabled
                                ? AppColors.white
                                : AppColors.submittingText,
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
