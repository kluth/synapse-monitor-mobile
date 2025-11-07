import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A customizable loading indicator widget.
///
/// Displays a circular progress indicator with an optional message.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    this.message,
    this.size = 40.0,
    this.color,
    super.key,
  });

  /// Optional message to display below the loading indicator
  final String? message;

  /// Size of the loading indicator
  final double size;

  /// Color of the loading indicator (defaults to theme primary color)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.colorScheme.primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: indicatorColor,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppColors.hintDark
                    : AppColors.hintLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// A small inline loading indicator for use in buttons or small spaces.
class SmallLoadingIndicator extends StatelessWidget {
  const SmallLoadingIndicator({
    this.size = 16.0,
    this.color,
    super.key,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).colorScheme.primary,
        strokeWidth: 2,
      ),
    );
  }
}

/// A shimmer loading effect for list items and cards.
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = 8.0,
    super.key,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final highlightColor = isDark
        ? AppColors.darkSurface.withOpacity(0.3)
        : AppColors.lightSurface.withOpacity(0.1);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}
