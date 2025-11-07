import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Utility class for formatting various data types for display.
///
/// Provides consistent formatting for:
/// - Dates and times
/// - Numbers and percentages
/// - Durations
/// - File sizes
/// - Metric values
class Formatters {
  Formatters._();

  // ============================================================================
  // DATE & TIME FORMATTERS
  // ============================================================================

  /// Format date to short format (e.g., "Jan 15, 2025")
  static String formatDateShort(DateTime date) {
    return DateFormat(AppConstants.dateFormatShort).format(date);
  }

  /// Format date to long format (e.g., "January 15, 2025")
  static String formatDateLong(DateTime date) {
    return DateFormat(AppConstants.dateFormatLong).format(date);
  }

  /// Format date and time (e.g., "Jan 15, 2025 14:30:45")
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }

  /// Format time only (e.g., "14:30:45")
  static String formatTime(DateTime dateTime) {
    return DateFormat(AppConstants.timeFormat).format(dateTime);
  }

  /// Format relative time (e.g., "2 hours ago", "just now")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // ============================================================================
  // NUMBER FORMATTERS
  // ============================================================================

  /// Format number with thousand separators (e.g., "1,234,567")
  static String formatNumber(num number) {
    return NumberFormat('#,###').format(number);
  }

  /// Format number with decimal places (e.g., "1,234.56")
  static String formatDecimal(num number, [int decimals = AppConstants.decimalPlaces]) {
    return NumberFormat('#,###.${'#' * decimals}').format(number);
  }

  /// Format as percentage (e.g., "75.5%")
  static String formatPercentage(
    num value, [
    int decimals = AppConstants.percentageDecimalPlaces,
  ]) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  /// Format as compact number (e.g., "1.2K", "3.5M")
  static String formatCompactNumber(num number) {
    return NumberFormat.compact().format(number);
  }

  /// Format as currency (e.g., "$1,234.56")
  static String formatCurrency(num amount, [String symbol = '\$']) {
    return NumberFormat.currency(symbol: symbol).format(amount);
  }

  // ============================================================================
  // DURATION FORMATTERS
  // ============================================================================

  /// Format duration to human-readable string (e.g., "2h 30m 15s")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];

    if (hours > 0) {
      parts.add('${hours}h');
    }
    if (minutes > 0) {
      parts.add('${minutes}m');
    }
    if (seconds > 0 || parts.isEmpty) {
      parts.add('${seconds}s');
    }

    return parts.join(' ');
  }

  /// Format duration in milliseconds (e.g., "125ms")
  static String formatMilliseconds(Duration duration) {
    return '${duration.inMilliseconds}ms';
  }

  /// Format duration as uptime (e.g., "2 days, 3 hours")
  static String formatUptime(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    final parts = <String>[];

    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }
    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }
    if (minutes > 0 && days == 0) {
      parts.add('$minutes ${minutes == 1 ? 'minute' : 'minutes'}');
    }

    return parts.isEmpty ? 'just started' : parts.join(', ');
  }

  // ============================================================================
  // FILE SIZE FORMATTERS
  // ============================================================================

  /// Format bytes to human-readable size (e.g., "1.5 MB")
  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) {
      return '0 B';
    }

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    final i = (bytes.bitLength - 1) ~/ 10;
    final size = bytes / (1 << (i * 10));

    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  // ============================================================================
  // METRIC VALUE FORMATTERS
  // ============================================================================

  /// Format metric value with appropriate suffix (e.g., "1.2K req/s")
  static String formatMetricValue(num value, String unit) {
    final formattedValue = value >= 1000
        ? formatCompactNumber(value)
        : formatDecimal(value);

    return '$formattedValue $unit';
  }

  /// Format health score (0-100) with status
  static String formatHealthScore(double score) {
    return '${score.toStringAsFixed(1)}%';
  }

  /// Format rate (requests per second, etc.)
  static String formatRate(num rate, String unit) {
    return '${formatDecimal(rate)}/$unit';
  }

  /// Format weight (0.0 - 1.0) as percentage
  static String formatWeight(double weight) {
    return formatPercentage(weight * 100);
  }

  /// Format threshold value
  static String formatThreshold(double threshold) {
    return formatDecimal(threshold);
  }

  // ============================================================================
  // SPECIALIZED FORMATTERS
  // ============================================================================

  /// Format neuron ID (truncate if too long)
  static String formatNeuronId(String id, [int maxLength = 8]) {
    if (id.length <= maxLength) {
      return id;
    }
    return '${id.substring(0, maxLength)}...';
  }

  /// Format error count with optional threshold highlighting
  static String formatErrorCount(int count, [int threshold = 10]) {
    return formatNumber(count);
  }

  /// Format cache hit rate as percentage
  static String formatCacheHitRate(double hitRate) {
    return formatPercentage(hitRate);
  }

  /// Format signal count with compact notation if large
  static String formatSignalCount(int count) {
    return count >= 1000 ? formatCompactNumber(count) : formatNumber(count);
  }

  /// Format connection pool usage (e.g., "45/100 (45%)")
  static String formatPoolUsage(int current, int total) {
    final percentage = (current / total * 100).toStringAsFixed(0);
    return '${formatNumber(current)}/${formatNumber(total)} ($percentage%)';
  }

  /// Format latency in milliseconds
  static String formatLatency(Duration latency) {
    if (latency.inMilliseconds < 1000) {
      return '${latency.inMilliseconds}ms';
    }
    return '${(latency.inMilliseconds / 1000).toStringAsFixed(2)}s';
  }

  /// Format TTL (Time To Live)
  static String formatTTL(Duration ttl) {
    if (ttl.inMinutes < 1) {
      return '${ttl.inSeconds}s';
    } else if (ttl.inHours < 1) {
      return '${ttl.inMinutes}m';
    } else if (ttl.inDays < 1) {
      return '${ttl.inHours}h';
    } else {
      return '${ttl.inDays}d';
    }
  }

  /// Format request count
  static String formatRequestCount(int count) {
    return formatCompactNumber(count);
  }

  /// Format timestamp for logs
  static String formatLogTimestamp(DateTime timestamp) {
    return formatDateTime(timestamp);
  }
}
