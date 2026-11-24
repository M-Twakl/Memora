import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memora/core/constants/app_assets.dart';
import 'splash_cross_badge.dart';

/// Centers the Memora logo and positions the interactive cross badge.
/// Sized at 129.43 x 131.37 to match the Native Splash screen display 1:1.
class SplashLogoWidget extends StatelessWidget {
  final double rotationAngle;
  final double crossOpacity;
  final bool showBadge;
  final GlobalKey? badgeKey;

  const SplashLogoWidget({
    super.key,
    this.rotationAngle = 0.0,
    this.crossOpacity = 1.0,
    this.showBadge = true,
    this.badgeKey,
  });

  // Dimensions precisely matched to the Native Splash screenshot measurements
  static const double logoWidth = 129.43;
  static const double logoHeight = 131.37;
  static const double badgeOffsetX = 77.69;
  static const double badgeOffsetY = 69.19;
  static const double badgeSize = 21.85;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: logoWidth,
      height: logoHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Base Memora Logo SVG
          SvgPicture.asset(
            AppAssets.memoraLogoBase,
            width: logoWidth,
            height: logoHeight,
            fit: BoxFit.contain,
          ),

          // Circular Cross Badge positioned according to matching coordinates
          if (showBadge)
            Positioned(
              left: badgeOffsetX,
              top: badgeOffsetY,
              child: KeyedSubtree(
                key: badgeKey,
                child: SplashCrossBadge(
                  size: badgeSize,
                  rotationAngle: rotationAngle,
                  crossOpacity: crossOpacity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
