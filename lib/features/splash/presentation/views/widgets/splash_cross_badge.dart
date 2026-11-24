import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_colors.dart';

/// The small circular medical cross badge positioned on the Memora logo.
/// Supports rotation animation and fading/disappearing of the white cross.
class SplashCrossBadge extends StatelessWidget {
  final double size;
  final double rotationAngle;
  final double crossOpacity;

  const SplashCrossBadge({
    super.key,
    this.size = 21.85,
    this.rotationAngle = 0.0,
    this.crossOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: crossOpacity > 0.001
            ? Center(
                child: Opacity(
                  opacity: crossOpacity.clamp(0.0, 1.0),
                  child: CustomPaint(
                    size: Size(size * (12.0 / 18.0), size * (12.0 / 18.0)),
                    painter: const _CrossPainter(color: AppColors.splashBackground),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _CrossPainter extends CustomPainter {
  final Color color;

  const _CrossPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const barThicknessRatio = 0.29; // ~3.5 / 12
    final barThickness = size.width * barThicknessRatio;
    final radius = Radius.circular(barThickness / 2);

    // Vertical bar
    final vRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: barThickness,
        height: size.height,
      ),
      radius,
    );
    canvas.drawRRect(vRect, paint);

    // Horizontal bar
    final hRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: barThickness,
      ),
      radius,
    );
    canvas.drawRRect(hRect, paint);
  }

  @override
  bool shouldRepaint(covariant _CrossPainter oldDelegate) =>
      oldDelegate.color != color;
}
