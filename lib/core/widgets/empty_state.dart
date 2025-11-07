import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A customizable empty state widget.
///
/// Displays an icon, title, message, and optional action button when
/// there is no data to show.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.message,
    this.icon,
    this.title,
    this.actionLabel,
    this.onAction,
    this.showIcon = true,
    super.key,
  });

  /// Title text (optional)
  final String? title;

  /// Message to display
  final String message;

  /// Icon to display (defaults to search_off)
  final IconData? icon;

  /// Label for action button (optional)
  final String? actionLabel;

  /// Callback when action button is pressed (optional)
  final VoidCallback? onAction;

  /// Whether to show the icon
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hintColor = isDark ? AppColors.hintDark : AppColors.hintLight;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: hintColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.search_off,
                  size: 64,
                  color: hintColor,
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: theme.textTheme.headlineSmall?.color,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            Text(
              message,
              style: AppTextStyles.bodyLarge.copyWith(
                color: hintColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A compact empty state for use in smaller spaces like cards.
class CompactEmptyState extends StatelessWidget {
  const CompactEmptyState({
    required this.message,
    this.icon,
    super.key,
  });

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hintColor = isDark ? AppColors.hintDark : AppColors.hintLight;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 48,
              color: hintColor,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// An inline empty state for use in lists.
class InlineEmptyState extends StatelessWidget {
  const InlineEmptyState({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hintColor = isDark ? AppColors.hintDark : AppColors.hintLight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: hintColor,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Specific empty states for different features
class EmptyNeurons extends StatelessWidget {
  const EmptyNeurons({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.memory_outlined,
      title: 'No Neurons Found',
      message:
          'There are no neural nodes currently active in the system. Check your Synapse backend connection.',
    );
  }
}

class EmptySynapses extends StatelessWidget {
  const EmptySynapses({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.hub_outlined,
      title: 'No Connections Found',
      message:
          'There are no synaptic connections in the network. Neurons may not be connected yet.',
    );
  }
}

class EmptyAlerts extends StatelessWidget {
  const EmptyAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.check_circle_outline,
      title: 'All Clear!',
      message:
          'No active alerts. Your system is running smoothly.',
      showIcon: true,
    );
  }
}

class EmptyMetrics extends StatelessWidget {
  const EmptyMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.analytics_outlined,
      title: 'No Metrics Available',
      message:
          'Metrics data is not available at the moment. Try refreshing.',
    );
  }
}

class EmptyErrors extends StatelessWidget {
  const EmptyErrors({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.check_circle_outline,
      title: 'No Errors Logged',
      message:
          'Great news! There are no errors in the system.',
    );
  }
}

class EmptySearchResults extends StatelessWidget {
  const EmptySearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.search_off,
      title: 'No Results Found',
      message:
          'We couldn\'t find any matching items. Try adjusting your search.',
    );
  }
}
