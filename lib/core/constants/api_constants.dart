/// API-related constants for the Synapse Monitor application.
///
/// This file contains all API endpoints, HTTP methods, and network configuration
/// constants used throughout the application.
class ApiConstants {
  ApiConstants._();

  // Base URLs - These should be overridden by .env file
  static const String defaultRestApiBaseUrl = 'http://localhost:3000/api';
  static const String defaultWebSocketUrl = 'ws://localhost:3000/monitor';

  // API Versioning
  static const String apiVersion = 'v1';

  // Timeout Configuration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // WebSocket Configuration
  static const Duration wsReconnectInterval = Duration(seconds: 5);
  static const int wsMaxReconnectAttempts = 10;
  static const Duration wsPingInterval = Duration(seconds: 30);

  // REST API Endpoints

  // Dashboard Endpoints
  static const String systemHealthEndpoint = '/system/health';
  static const String activeAlertsEndpoint = '/alerts/active';
  static const String networkTopologyEndpoint = '/network/topology';

  // Neuron Endpoints
  static const String neuronsEndpoint = '/neurons';
  static String neuronByIdEndpoint(String id) => '/neurons/$id';
  static String neuronMetricsEndpoint(String id) => '/neurons/$id/metrics';
  static const String neuronsByTypeEndpoint = '/neurons/by-type';

  // Synapse Endpoints
  static const String synapsesEndpoint = '/synapses';
  static String synapseByIdEndpoint(String id) => '/synapses/$id';
  static const String networkGraphEndpoint = '/synapses/graph';
  static const String pruningCandidatesEndpoint = '/synapses/pruning-candidates';

  // Glial Cell Endpoints
  static const String astrocyteStatsEndpoint = '/glial-cells/astrocyte/stats';
  static const String oligodendrocyteStatsEndpoint =
      '/glial-cells/oligodendrocyte/stats';
  static const String microgliaMetricsEndpoint =
      '/glial-cells/microglia/metrics';
  static const String ependymalStatsEndpoint = '/glial-cells/ependymal/stats';

  // System Health Endpoints
  static const String errorLogsEndpoint = '/system/errors';
  static const String metricsEndpoint = '/system/metrics';
  static const String neuroplasticityEventsEndpoint =
      '/system/neuroplasticity-events';
  static const String healthChecksEndpoint = '/system/health-checks';

  // Notification Endpoints
  static const String subscribeAlertsEndpoint = '/notifications/subscribe';
  static const String notificationSettingsEndpoint = '/notifications/settings';
  static const String notificationHistoryEndpoint = '/notifications/history';

  // WebSocket Events
  static const String wsEventSystemHealth = 'system:health';
  static const String wsEventNeuronUpdate = 'neuron:update';
  static const String wsEventSynapseUpdate = 'synapse:update';
  static const String wsEventAlert = 'alert:new';
  static const String wsEventError = 'error:occurred';
  static const String wsEventMetric = 'metric:update';
  static const String wsEventTopologyChange = 'topology:change';

  // HTTP Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerApiKey = 'X-API-Key';
  static const String headerAccept = 'Accept';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormUrlEncoded =
      'application/x-www-form-urlencoded';

  // Cache Configuration
  static const Duration cacheMaxAge = Duration(minutes: 5);
  static const int maxCacheSize = 100;
}
