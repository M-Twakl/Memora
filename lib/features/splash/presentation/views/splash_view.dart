import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_durations.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'widgets/splash_expanding_circle.dart';
import 'widgets/splash_logo_widget.dart';

/// Full-screen Splash View orchestrating the 3-phase Figma transition:
/// 1. Frame 1: Standard splash with centered Memora logo & cross badge (1.5s delay).
/// 2. Frame 2: 45° badge rotation + cross fade-out (300ms ease-out + 300ms pause).
/// 3. Frame 3: Blue circular flood expansion (800ms ease-out + 200ms hold), then navigate.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final Animation<double> _rotateAnimation;
  late final Animation<double> _crossFadeAnimation;

  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  final GlobalKey _badgeKey = GlobalKey();
  Offset? _badgeCenter;

  @override
  void initState() {
    super.initState();

    // 1. Rotation and Fade Animation (Phase 2: Rotate cross badge 45° & fade out white cross)
    _rotateController = AnimationController(
      vsync: this,
      duration: AppDurations.splashRotateDuration,
    );

    _rotateAnimation =
        Tween<double>(
          begin: 0.0,
          end: math.pi / 4, // 45 degrees
        ).animate(
          CurvedAnimation(parent: _rotateController, curve: Curves.easeOut),
        );

    _crossFadeAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.0, // Fades out and disappears
        ).animate(
          CurvedAnimation(
            parent: _rotateController,
            curve: const Interval(0.2, 0.95, curve: Curves.easeOut),
          ),
        );

    // 2. Flood Expansion Animation (Phase 3: Circular flood from badge center)
    _expandController = AnimationController(
      vsync: this,
      duration: AppDurations.splashExpandDuration,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOut,
    );

    // Schedule post-frame calculation, native splash removal, and sequence start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
      _calculateBadgeCenter();
      _startSplashSequence();
    });
  }

  void _calculateBadgeCenter() {
    final renderBox =
        _badgeKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final topLeft = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _badgeCenter = Offset(
          topLeft.dx + renderBox.size.width / 2,
          topLeft.dy + renderBox.size.height / 2,
        );
      });
    }
  }

  Future<void> _startSplashSequence() async {
    // Stage 1: Hold initial standard splash (1500ms)
    await Future.delayed(AppDurations.splashInitialDelay);
    if (!mounted) return;

    // Recalculate badge center in case layout changed
    _calculateBadgeCenter();

    // Stage 2: Rotate cross badge 45 degrees & fade out cross until it disappears (300ms)
    await _rotateController.forward();
    if (!mounted) return;

    // Stage 2 pause: Hold rotated badge state without cross (300ms)
    await Future.delayed(AppDurations.splashBadgePause);
    if (!mounted) return;

    // Stage 3: Expand circular blue flood outward from badge center (800ms)
    await _expandController.forward();
    if (!mounted) return;

    // Stage 3 hold: Hold solid blue screen (200ms)
    await Future.delayed(AppDurations.splashFinalHold);
    if (!mounted) return;

    // Navigation: Smooth transition to Onboarding
    context.go(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If screen size changes, update badge coordinates
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _calculateBadgeCenter();
          });

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Centered Memora Logo with badge
              Center(
                child: AnimatedBuilder(
                  animation: _rotateController,
                  builder: (context, child) {
                    return SplashLogoWidget(
                      rotationAngle: _rotateAnimation.value,
                      crossOpacity: _crossFadeAnimation.value,
                      badgeKey: _badgeKey,
                    );
                  },
                ),
              ),

              // 2. Expanding Blue Circle Overlay (Frame 3 Transition)
              AnimatedBuilder(
                animation: _expandAnimation,
                builder: (context, child) {
                  return SplashExpandingCircle(
                    origin: _badgeCenter,
                    progress: _expandAnimation.value,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
