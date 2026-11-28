import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';

/// Header section for Persona selection screen matching Figma Frame 1:1282.
/// Displays title "How will you use Memora?" and subtitle "You can select more than one role.".
class PersonaHeaderSection extends StatelessWidget {
  const PersonaHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.personaTitle,
          style: GoogleFonts.alexandria(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textOnboardingDark,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.personaSubtitle,
          style: GoogleFonts.alexandria(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.textOnboardingDark,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
