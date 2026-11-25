import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_colors.dart';

/// Expands a solid blue circle from the cross badge's origin to flood the entire viewport.
/// Corresponds to Figma Frame 3 (`1:4058`), where the 18px circle expands to flood the screen.
class SplashExpandingCircle extends StatelessWidget {
  /// The global screen offset of the center of the cross badge.
  final Offset? origin;

  /// Progress from 0.0 (no expansion) to 1.0 (fully covering screen).
  final double progress;

  const SplashExpandingCircle({
    super.key,
    required this.origin,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    if (progress <= 0.0 || origin == null) {
      return const SizedBox.shrink();
    }

    final screenSize = MediaQuery.sizeOf(context);

    // Compute maximum distance from the origin point to all 4 screen corners
    final double maxDistToCorner = [
      origin!,
      Offset(origin!.dx, screenSize.height) - origin!,
      Offset(screenSize.width, 0) - origin!,
      Offset(screenSize.width, screenSize.height) - origin!,
    ].map((d) => d.distance).reduce(math.max);

    // Add extra margin to ensure complete corner coverage across all aspect ratios
    final double targetRadius = math.max(maxDistToCorner * 1.15, 600.0);
    const double initialRadius = 10.93;
    final double currentRadius =
        initialRadius + (targetRadius - initialRadius) * progress;

    return IgnorePointer(
      child: CustomPaint(
        size: screenSize,
        painter: _CircleFloodPainter(
          center: origin!,
          radius: currentRadius,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}

class _CircleFloodPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  const _CircleFloodPainter({
    required this.center,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleFloodPainter oldDelegate) =>
      oldDelegate.center != center ||
      oldDelegate.radius != radius ||
      oldDelegate.color != color;
}
