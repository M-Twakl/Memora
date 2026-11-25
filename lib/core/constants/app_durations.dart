/// Centralized animation durations and delays reflecting Figma prototype specs.
abstract class AppDurations {
  // Splash Screen Prototype Timing
  /// Frame 1 display timeout before transition begins (1.5s in Figma).
  static const Duration splashInitialDelay = Duration(milliseconds: 1500);

  /// Frame 1 to Frame 2 transition (300ms ease-out smart animate).
  static const Duration splashRotateDuration = Duration(milliseconds: 300);

  /// Frame 2 pause before expansion begins (300ms timeout in Figma).
  static const Duration splashBadgePause = Duration(milliseconds: 300);

  /// Frame 2 to Frame 3 blue circular flood expansion (800ms ease-out smart animate).
  static const Duration splashExpandDuration = Duration(milliseconds: 800);

  /// Frame 3 blue screen hold before navigation (200ms timeout in Figma).
  static const Duration splashFinalHold = Duration(milliseconds: 200);

  /// Navigation route transition duration (300ms ease-out in Figma).
  static const Duration splashNavTransition = Duration(milliseconds: 300);

  // General App Animations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
}
