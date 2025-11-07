/// Route constants for navigation in the Synapse Monitor application.
///
/// This file contains all route paths used by GoRouter for navigation.
class RouteConstants {
  RouteConstants._();

  // Root Routes
  static const String splash = '/';
  static const String dashboard = '/dashboard';

  // Neuron Routes
  static const String neurons = '/neurons';
  static const String neuronDetail = '/neurons/:id';
  static String neuronDetailPath(String id) => '/neurons/$id';

  // Synapse Routes
  static const String synapses = '/synapses';
  static const String synapsesGraph = '/synapses/graph';
  static const String synapseDetail = '/synapses/:id';
  static String synapseDetailPath(String id) => '/synapses/$id';

  // Glial Cells Routes
  static const String glialCells = '/glial-cells';
  static const String astrocyte = '/glial-cells/astrocyte';
  static const String oligodendrocyte = '/glial-cells/oligodendrocyte';
  static const String microglia = '/glial-cells/microglia';
  static const String ependymal = '/glial-cells/ependymal';

  // System Health Routes
  static const String systemHealth = '/system-health';
  static const String errorLogs = '/system-health/errors';
  static const String metrics = '/system-health/metrics';
  static const String neuroplasticity = '/system-health/neuroplasticity';

  // Notification Routes
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';

  // Settings Routes
  static const String settings = '/settings';
  static const String about = '/settings/about';
  static const String connectionSettings = '/settings/connection';

  // Route Names (for named navigation)
  static const String splashName = 'splash';
  static const String dashboardName = 'dashboard';
  static const String neuronsName = 'neurons';
  static const String neuronDetailName = 'neuron-detail';
  static const String synapsesName = 'synapses';
  static const String synapsesGraphName = 'synapses-graph';
  static const String synapseDetailName = 'synapse-detail';
  static const String glialCellsName = 'glial-cells';
  static const String astrocyteName = 'astrocyte';
  static const String oligodendrocyteName = 'oligodendrocyte';
  static const String microgliaName = 'microglia';
  static const String ependymalName = 'ependymal';
  static const String systemHealthName = 'system-health';
  static const String errorLogsName = 'error-logs';
  static const String metricsName = 'metrics';
  static const String neuroplasticityName = 'neuroplasticity';
  static const String notificationsName = 'notifications';
  static const String notificationSettingsName = 'notification-settings';
  static const String settingsName = 'settings';
  static const String aboutName = 'about';
  static const String connectionSettingsName = 'connection-settings';
}
