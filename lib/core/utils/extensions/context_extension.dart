import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide convenient media query and responsive helpers.
extension ContextExtension on BuildContext {
  // Screen Dimensions
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  // Breakpoints
  // Mobile: < 600dp
  // Tablet: 600dp - 1023dp
  // Desktop/Web: >= 1024dp
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  /// Returns responsive value based on current device type.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}
