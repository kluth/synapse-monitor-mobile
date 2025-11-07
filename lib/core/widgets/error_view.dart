import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../errors/failures.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A customizable error view widget.
///
/// Displays an error icon, message, and optional retry button.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    this.onRetry,
    this.icon,
    this.showIcon = true,
    super.key,
  });

  /// Error message to display
  final String message;

  /// Callback when retry button is pressed
  final VoidCallback? onRetry;

  /// Custom icon to display (defaults to error icon)
  final IconData? icon;

  /// Whether to show the icon
  final bool showIcon;

  /// Create ErrorView from a Failure
  factory ErrorView.fromFailure(
    Failure failure, {
    VoidCallback? onRetry,
    Key? key,
  }) {
    return ErrorView(
      message: failure.message,
      onRetry: onRetry,
      icon: _getIconForFailure(failure),
      key: key,
    );
  }

  static IconData _getIconForFailure(Failure failure) {
    if (failure is NetworkFailure) {
      return Icons.wifi_off;
    } else if (failure is TimeoutFailure) {
      return Icons.access_time;
    } else if (failure is UnauthorizedFailure) {
      return Icons.lock;
    } else if (failure is NotFoundFailure) {
      return Icons.search_off;
    } else {
      return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final errorColor = isDark ? AppColors.errorDark : AppColors.error;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.error_outline,
                  size: 64,
                  color: errorColor,
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              'Oops!',
              style: AppTextStyles.headlineSmall.copyWith(
                color: errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: AppTextStyles.bodyLarge.copyWith(
                color: theme.textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: errorColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A compact error widget for use in smaller spaces.
class CompactErrorView extends StatelessWidget {
  const CompactErrorView({
    required this.message,
    this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final errorColor = isDark ? AppColors.errorDark : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: errorColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: errorColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 12),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              iconSize: 20,
              color: errorColor,
              tooltip: 'Retry',
            ),
          ],
        ],
      ),
    );
  }
}

/// A banner-style error widget.
class ErrorBanner extends StatelessWidget {
  const ErrorBanner({
    required this.message,
    this.onDismiss,
    super.key,
  });

  final String message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final errorColor = isDark ? AppColors.errorDark : AppColors.error;

    return Material(
      color: errorColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onDismiss,
                  icon: const Icon(Icons.close),
                  iconSize: 20,
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper function to show a snackbar with error message.
void showErrorSnackBar(BuildContext context, String message, {VoidCallback? onRetry}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.errorDark
          : AppColors.error,
      action: onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: onRetry,
            )
          : null,
      duration: const Duration(seconds: 4),
    ),
  );
}
