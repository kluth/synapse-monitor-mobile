/// General application constants for the Synapse Monitor application.
///
/// This file contains app-wide configuration values, limits, and settings.
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Synapse Monitor';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Monitoring Configuration
  static const Duration pollingInterval = Duration(seconds: 30);
  static const Duration healthCheckInterval = Duration(minutes: 1);
  static const Duration metricsRetentionPeriod = Duration(hours: 24);

  // UI Configuration
  static const int chartMaxDataPoints = 50;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Chart Configuration
  static const int maxChartPoints = 100;
  static const Duration chartUpdateInterval = Duration(seconds: 5);

  // Thresholds
  static const double errorRateThreshold = 10.0; // 10%
  static const double healthScoreThreshold = 70.0; // 70%
  static const int connectionPoolThreshold = 80; // 80%
  static const double cacheHitRateWarning = 50.0; // 50%
  static const double cacheHitRateCritical = 30.0; // 30%

  // Neuron Status
  static const String neuronStatusActive = 'active';
  static const String neuronStatusInactive = 'inactive';
  static const String neuronStatusError = 'error';
  static const String neuronStatusWarning = 'warning';

  // Neuron Types
  static const String neuronTypeBase = 'neural_node';
  static const String neuronTypeCortical = 'cortical';
  static const String neuronTypeReflex = 'reflex';

  // Synapse Signal Types
  static const String signalTypeExcitatory = 'excitatory';
  static const String signalTypeInhibitory = 'inhibitory';

  // Alert Severities
  static const String alertSeverityCritical = 'critical';
  static const String alertSeverityWarning = 'warning';
  static const String alertSeverityInfo = 'info';

  // Glial Cell Types
  static const String glialCellAstrocyte = 'astrocyte';
  static const String glialCellOligodendrocyte = 'oligodendrocyte';
  static const String glialCellMicroglia = 'microglia';
  static const String glialCellEpendymal = 'ependymal';

  // Date Formats
  static const String dateFormatShort = 'MMM dd, yyyy';
  static const String dateFormatLong = 'MMMM dd, yyyy';
  static const String dateTimeFormat = 'MMM dd, yyyy HH:mm:ss';
  static const String timeFormat = 'HH:mm:ss';

  // Number Formats
  static const int decimalPlaces = 2;
  static const int percentageDecimalPlaces = 1;

  // Storage Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyApiEndpoint = 'api_endpoint';
  static const String keyWebSocketUrl = 'websocket_url';
  static const String keyAuthToken = 'auth_token';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyOfflineModeEnabled = 'offline_mode_enabled';
  static const String keyDebugLoggingEnabled = 'debug_logging_enabled';

  // Feature Flags
  static const bool enablePushNotifications = true;
  static const bool enableOfflineMode = true;
  static const bool enableDebugLogging = false;

  // Network Configuration
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration backoffMultiplier = Duration(seconds: 2);

  // Cache Configuration
  static const Duration defaultCacheDuration = Duration(minutes: 5);
  static const int maxCacheEntries = 100;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;

  // Graph Configuration
  static const int maxGraphNodes = 1000;
  static const int maxGraphEdges = 5000;
  static const double graphZoomMin = 0.5;
  static const double graphZoomMax = 3.0;

  // Error Messages
  static const String errorNetworkUnavailable =
      'Network unavailable. Please check your connection.';
  static const String errorServerUnavailable =
      'Unable to connect to server. Please try again later.';
  static const String errorUnknown = 'An unexpected error occurred.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorUnauthorized =
      'Unauthorized access. Please check your credentials.';

  // Success Messages
  static const String successDataRefreshed = 'Data refreshed successfully';
  static const String successSettingsSaved = 'Settings saved successfully';
  static const String successNotificationSubscribed =
      'Successfully subscribed to notifications';

  // Empty State Messages
  static const String emptyNeurons = 'No neurons found';
  static const String emptySynapses = 'No synapses found';
  static const String emptyAlerts = 'No active alerts';
  static const String emptyMetrics = 'No metrics available';
  static const String emptyErrors = 'No errors logged';

  // Loading Messages
  static const String loadingData = 'Loading data...';
  static const String loadingNeurons = 'Loading neurons...';
  static const String loadingSynapses = 'Loading synapses...';
  static const String loadingMetrics = 'Loading metrics...';

  // URLs
  static const String synapseFrameworkUrl = 'https://github.com/kluth/synapse';
  static const String documentationUrl = 'https://docs.synapse-framework.com';
  static const String issuesUrl =
      'https://github.com/kluth/synapse-monitor-mobile/issues';
}
