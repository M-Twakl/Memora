import 'package:flutter/material.dart';

/// Renders different widget trees based on device screen breakpoint.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024 && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= 600 && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}

/// Wraps widgets with a maximum width constraint, centered on larger screens (Tablet/Desktop/Web).
class AdaptiveMaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const AdaptiveMaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = 600,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );
  }
}
