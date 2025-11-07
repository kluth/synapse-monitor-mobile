/// Utility class for input validation.
///
/// Provides validators for:
/// - URLs and endpoints
/// - Numbers and ranges
/// - Required fields
/// - Custom formats
class Validators {
  Validators._();

  // ============================================================================
  // URL VALIDATORS
  // ============================================================================

  /// Validate URL format
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );

    if (!urlPattern.hasMatch(value)) {
      return 'Invalid URL format';
    }

    return null;
  }

  /// Validate WebSocket URL
  static String? validateWebSocketUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'WebSocket URL is required';
    }

    if (!value.startsWith('ws://') && !value.startsWith('wss://')) {
      return 'WebSocket URL must start with ws:// or wss://';
    }

    return null;
  }

  /// Validate API endpoint (can be relative or absolute)
  static String? validateEndpoint(String? value) {
    if (value == null || value.isEmpty) {
      return 'Endpoint is required';
    }

    // Allow relative URLs starting with /
    if (value.startsWith('/')) {
      return null;
    }

    // Validate as full URL
    return validateUrl(value);
  }

  // ============================================================================
  // NUMBER VALIDATORS
  // ============================================================================

  /// Validate required field
  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate number
  static String? validateNumber(String? value, [String fieldName = 'Value']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Validate integer
  static String? validateInteger(String? value, [String fieldName = 'Value']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid integer';
    }

    return null;
  }

  /// Validate number is positive
  static String? validatePositive(String? value, [String fieldName = 'Value']) {
    final numberError = validateNumber(value, fieldName);
    if (numberError != null) {
      return numberError;
    }

    final number = double.parse(value!);
    if (number <= 0) {
      return '$fieldName must be positive';
    }

    return null;
  }

  /// Validate number is non-negative
  static String? validateNonNegative(String? value, [String fieldName = 'Value']) {
    final numberError = validateNumber(value, fieldName);
    if (numberError != null) {
      return numberError;
    }

    final number = double.parse(value!);
    if (number < 0) {
      return '$fieldName must be non-negative';
    }

    return null;
  }

  /// Validate number range
  static String? validateRange(
    String? value,
    num min,
    num max, [
    String fieldName = 'Value',
  ]) {
    final numberError = validateNumber(value, fieldName);
    if (numberError != null) {
      return numberError;
    }

    final number = double.parse(value!);
    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  /// Validate percentage (0-100)
  static String? validatePercentage(String? value, [String fieldName = 'Percentage']) {
    return validateRange(value, 0, 100, fieldName);
  }

  /// Validate weight (0.0-1.0)
  static String? validateWeight(String? value, [String fieldName = 'Weight']) {
    return validateRange(value, 0.0, 1.0, fieldName);
  }

  // ============================================================================
  // LENGTH VALIDATORS
  // ============================================================================

  /// Validate minimum length
  static String? validateMinLength(
    String? value,
    int minLength, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(
    String? value,
    int maxLength, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Allow empty for optional fields
    }

    if (value.length > maxLength) {
      return '$fieldName must be at most $maxLength characters';
    }

    return null;
  }

  /// Validate exact length
  static String? validateExactLength(
    String? value,
    int length, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length != length) {
      return '$fieldName must be exactly $length characters';
    }

    return null;
  }

  // ============================================================================
  // PATTERN VALIDATORS
  // ============================================================================

  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailPattern.hasMatch(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  /// Validate alphanumeric
  static String? validateAlphanumeric(String? value, [String fieldName = 'Field']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');

    if (!alphanumericPattern.hasMatch(value)) {
      return '$fieldName must contain only letters and numbers';
    }

    return null;
  }

  /// Validate neuron ID format
  static String? validateNeuronId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Neuron ID is required';
    }

    // Allow alphanumeric and hyphens
    final idPattern = RegExp(r'^[a-zA-Z0-9-]+$');

    if (!idPattern.hasMatch(value)) {
      return 'Invalid neuron ID format';
    }

    return null;
  }

  // ============================================================================
  // TIMEOUT VALIDATORS
  // ============================================================================

  /// Validate timeout value in milliseconds
  static String? validateTimeout(String? value) {
    final numberError = validatePositive(value, 'Timeout');
    if (numberError != null) {
      return numberError;
    }

    final timeout = int.parse(value!);
    if (timeout < 1000) {
      return 'Timeout must be at least 1000ms';
    }

    if (timeout > 300000) {
      return 'Timeout must be at most 300000ms (5 minutes)';
    }

    return null;
  }

  /// Validate interval value in milliseconds
  static String? validateInterval(String? value) {
    final numberError = validatePositive(value, 'Interval');
    if (numberError != null) {
      return numberError;
    }

    final interval = int.parse(value!);
    if (interval < 1000) {
      return 'Interval must be at least 1000ms';
    }

    return null;
  }

  // ============================================================================
  // CUSTOM VALIDATORS
  // ============================================================================

  /// Validate API key format (if it has a specific format)
  static String? validateApiKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'API key is required';
    }

    if (value.length < 16) {
      return 'API key must be at least 16 characters';
    }

    return null;
  }

  /// Validate port number
  static String? validatePort(String? value) {
    final intError = validateInteger(value, 'Port');
    if (intError != null) {
      return intError;
    }

    final port = int.parse(value!);
    if (port < 1 || port > 65535) {
      return 'Port must be between 1 and 65535';
    }

    return null;
  }

  /// Validate IP address
  static String? validateIpAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'IP address is required';
    }

    final ipPattern = RegExp(
      r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$',
    );

    if (!ipPattern.hasMatch(value)) {
      return 'Invalid IP address format';
    }

    // Validate each octet
    final parts = value.split('.');
    for (final part in parts) {
      final octet = int.parse(part);
      if (octet < 0 || octet > 255) {
        return 'Invalid IP address';
      }
    }

    return null;
  }

  /// Combine multiple validators
  static String? combine(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
