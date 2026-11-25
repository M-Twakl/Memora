import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/core/theme/app_text_styles.dart';

/// Horizontally moving/scrolling validation error text widget.
/// When the error message exceeds the available width, it smoothly animates
/// horizontally back and forth at a calm, readable pace with gentle pauses
/// at each end so the entire message is completely displayed.
class MarqueeErrorText extends StatefulWidget {
  final String errorText;
  final TextStyle? style;
  final double? width;

  const MarqueeErrorText({
    super.key,
    required this.errorText,
    this.style,
    this.width,
  });

  @override
  State<MarqueeErrorText> createState() => _MarqueeErrorTextState();
}

class _MarqueeErrorTextState extends State<MarqueeErrorText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  double _overflowDistance = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    // Interval(0.12, 0.88) creates a comfortable pause at both the beginning
    // and the end so the user can easily read the full message.
    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.88, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant MarqueeErrorText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorText != widget.errorText) {
      _controller.reset();
      _overflowDistance = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateOverflow(double maxWidth, TextStyle effectiveStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.errorText, style: effectiveStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: double.infinity);

    // Padding inside the marquee container is 16 on left + 16 on right = 32
    final usableWidth = maxWidth - 32.0;

    // Alexandria is a wide geometric font (~7.6-7.8px per char at 12sp).
    // If the font is loading or system fallback is used during initial measurement,
    // math.max guarantees we never underestimate the real rendered Alexandria width.
    final estimatedAlexandriaWidth = widget.errorText.length * 7.7;
    final effectiveTextWidth = math.max(textPainter.width, estimatedAlexandriaWidth);

    final distance = effectiveTextWidth - usableWidth;

    // Trigger marquee if text clearly overflows or is within a narrow margin of the edge
    if (distance > 0 || (widget.errorText.length >= 35 && effectiveTextWidth >= usableWidth - 8.0)) {
      final newOverflow = math.max(distance, 20.0) + 16.0;
      if ((newOverflow - _overflowDistance).abs() > 1.0) {
        _overflowDistance = newOverflow;
        // Calm, slower scrolling speed (~12-14 pixels/sec)
        final seconds = (_overflowDistance / 12.0).clamp(6.0, 14.0);
        _controller.duration = Duration(milliseconds: (seconds * 1000).toInt());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_controller.isAnimating) {
            _controller.repeat(reverse: true);
          }
        });
      }
    } else {
      if (_overflowDistance != 0.0) {
        _overflowDistance = 0.0;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _controller.isAnimating) {
            _controller.stop();
            _controller.reset();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ??
        AppTextStyles.caption.copyWith(
          color: AppColors.accentPink,
          fontSize: 12,
        );

    final screenWidth = MediaQuery.of(context).size.width;
    final defaultWidth = screenWidth > 480 ? 480.0 - 40.0 : screenWidth - 40.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = widget.width ??
            ((constraints.maxWidth.isFinite && constraints.maxWidth > 0)
                ? constraints.maxWidth
                : defaultWidth);

        _updateOverflow(availableWidth, effectiveStyle);

        if (_overflowDistance <= 0) {
          return Container(
            width: availableWidth,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
            child: Text(
              widget.errorText,
              style: effectiveStyle,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.left,
            ),
          );
        }

        return Container(
          width: availableWidth,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
          child: ClipRect(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-_overflowDistance * _animation.value, 0),
                    child: child,
                  );
                },
                child: Text(
                  widget.errorText,
                  style: effectiveStyle,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
