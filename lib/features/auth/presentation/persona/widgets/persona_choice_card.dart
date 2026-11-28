import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memora/core/theme/app_colors.dart';

/// Choice card representing a persona role matching Figma Component 'choise' (1:64 & 1:66).
/// - Default (unselected): outlined in primary blue, transparent background, blue text.
/// - Selected: primary blue border, 50% opacity blue fill (0x803697F5), white text.
class PersonaChoiceCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PersonaChoiceCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: 51.0,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0x803697F5) // Figma variant 1:66 fill (rgba 54, 151, 245, 0.5)
            : AppColors.white,
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: AppColors.primaryBlue,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40.0),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.alexandria(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.white : AppColors.primaryBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
