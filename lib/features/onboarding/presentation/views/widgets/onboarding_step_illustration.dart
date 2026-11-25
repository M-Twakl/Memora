import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';

/// Modular widget that renders layered vector illustrations for each onboarding step.
/// All SVG layers share the exact 393x470 coordinate space, ensuring 100% precision with
/// the Figma design while allowing each floating element to animate independently.
class OnboardingStepIllustration extends StatelessWidget {
  final int stepIndex;
  final bool animate;

  const OnboardingStepIllustration({
    super.key,
    required this.stepIndex,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (stepIndex) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
      default:
        return _buildStep3();
    }
  }

  Widget _buildLayer(String assetPath, {Widget Function(Widget)? animation}) {
    final svgWidget = SvgPicture.asset(
      assetPath,
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );

    if (!animate || animation == null) {
      return svgWidget;
    }
    return animation(svgWidget);
  }

  /// Step 1: Medical Record card with heart, cross, capsule, stats, particles
  Widget _buildStep1() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Static base wave with shadow (touches screen edges seamlessly)
        _buildLayer(AppAssets.s1BaseWave),

        // 2. Hero Medical Record Card - gentle floating bob
        _buildLayer(
          AppAssets.s1HeroCard,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -4,
                end: 4,
                duration: 2800.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 3. Top-Right Floating Heart - rhythmic float and subtle heart pulse
        _buildLayer(
          AppAssets.s1Heart,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -8,
                end: 8,
                duration: 2200.ms,
                curve: Curves.easeInOutSine,
              )
              .scale(
                begin: const Offset(0.96, 0.96),
                end: const Offset(1.04, 1.04),
                duration: 2200.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 4. Top-Left Floating Medical Cross
        _buildLayer(
          AppAssets.s1Cross,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 6,
                end: -6,
                duration: 2500.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 5. Bottom-Right Floating Capsule / Pill
        _buildLayer(
          AppAssets.s1Capsule,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -5,
                end: 5,
                duration: 2000.ms,
                curve: Curves.easeInOutSine,
              )
              .rotate(
                begin: -0.02,
                end: 0.02,
                duration: 2000.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 6. Bottom-Left Dark Stats Badge with Bar Chart
        _buildLayer(
          AppAssets.s1Stats,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 5,
                end: -5,
                duration: 2400.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 7. Ambient Twinkle Particles
        _buildLayer(
          AppAssets.s1Particles,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.88, 0.88),
                end: const Offset(1.12, 1.12),
                duration: 1800.ms,
                curve: Curves.easeInOutSine,
              ),
        ),
      ],
    );
  }

  /// Step 2: Diagonal Syringe at ~35° with vial, drops, shield, calendar, particles
  Widget _buildStep2() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Static base wave with shadow
        _buildLayer(AppAssets.s2BaseWave),

        // 2. Hero Syringe - subtle floating motion along its diagonal axis
        _buildLayer(
          AppAssets.s2HeroSyringe,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -5,
                end: 5,
                duration: 2600.ms,
                curve: Curves.easeInOutSine,
              )
              .moveX(
                begin: -2,
                end: 2,
                duration: 2600.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 3. Medicine Vial with pink cap - vertical float
        _buildLayer(
          AppAssets.s2Vial,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 6,
                end: -6,
                duration: 2300.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 4. Liquid Droplets - floating bob
        _buildLayer(
          AppAssets.s2Drops,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -5,
                end: 5,
                duration: 1900.ms,
                curve: Curves.easeInOutSine,
              )
              .scale(
                begin: const Offset(0.93, 0.93),
                end: const Offset(1.07, 1.07),
                duration: 1900.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 5. Top-Right Protection Shield with checkmark
        _buildLayer(
          AppAssets.s2Shield,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -6,
                end: 6,
                duration: 2500.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 6. Top-Left Appointment Calendar
        _buildLayer(
          AppAssets.s2Calendar,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 6,
                end: -6,
                duration: 2700.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 7. Ambient Twinkle Particles
        _buildLayer(
          AppAssets.s2Particles,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.88, 0.88),
                end: const Offset(1.12, 1.12),
                duration: 1800.ms,
                curve: Curves.easeInOutSine,
              ),
        ),
      ],
    );
  }

  /// Step 3: Big Shield with padlock, patient file, key, check badge, mini lock, particles
  Widget _buildStep3() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Static base wave with shadow
        _buildLayer(AppAssets.s3BaseWave),

        // 2. Hero Security Shield with Padlock - solid, steady float
        _buildLayer(
          AppAssets.s3HeroShield,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -4,
                end: 4,
                duration: 3000.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 3. Bottom-Left Patient Card with heart
        _buildLayer(
          AppAssets.s3PatientFile,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 5,
                end: -5,
                duration: 2300.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 4. Bottom-Right Security Key
        _buildLayer(
          AppAssets.s3Key,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -6,
                end: 6,
                duration: 2100.ms,
                curve: Curves.easeInOutSine,
              )
              .rotate(
                begin: -0.03,
                end: 0.03,
                duration: 2100.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 5. Top-Left Cyan Checkmark Badge
        _buildLayer(
          AppAssets.s3CheckBadge,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -6,
                end: 6,
                duration: 2400.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 6. Top-Right Dark Mini Lock Badge
        _buildLayer(
          AppAssets.s3MiniLock,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 5,
                end: -5,
                duration: 2500.ms,
                curve: Curves.easeInOutSine,
              ),
        ),

        // 7. Ambient Twinkle Particles
        _buildLayer(
          AppAssets.s3Particles,
          animation: (w) => w
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.88, 0.88),
                end: const Offset(1.12, 1.12),
                duration: 1800.ms,
                curve: Curves.easeInOutSine,
              ),
        ),
      ],
    );
  }
}
