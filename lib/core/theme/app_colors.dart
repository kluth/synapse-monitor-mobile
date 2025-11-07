import 'package:flutter/material.dart';

/// Application color palette for light and dark themes.
///
/// Defines all colors used throughout the app with semantic naming
/// to ensure consistency and easy theming.
class AppColors {
  AppColors._();

  // ============================================================================
  // LIGHT THEME COLORS
  // ============================================================================

  /// Primary colors for light theme
  static const Color lightPrimary = Color(0xFF2196F3); // Blue
  static const Color lightPrimaryVariant = Color(0xFF1976D2);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);

  /// Secondary colors for light theme
  static const Color lightSecondary = Color(0xFF03DAC6); // Teal
  static const Color lightSecondaryVariant = Color(0xFF018786);
  static const Color lightOnSecondary = Color(0xFF000000);

  /// Background colors for light theme
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);

  /// Error colors for light theme
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // ============================================================================
  // DARK THEME COLORS
  // ============================================================================

  /// Primary colors for dark theme
  static const Color darkPrimary = Color(0xFF64B5F6); // Lighter blue
  static const Color darkPrimaryVariant = Color(0xFF42A5F5);
  static const Color darkOnPrimary = Color(0xFF000000);

  /// Secondary colors for dark theme
  static const Color darkSecondary = Color(0xFF80CBC4); // Light teal
  static const Color darkSecondaryVariant = Color(0xFF4DB6AC);
  static const Color darkOnSecondary = Color(0xFF000000);

  /// Background colors for dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);

  /// Error colors for dark theme
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnError = Color(0xFF000000);

  // ============================================================================
  // STATUS COLORS (Used in both themes)
  // ============================================================================

  /// Success/healthy status
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color successDark = Color(0xFF81C784);

  /// Warning status
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color warningDark = Color(0xFFFFD54F);

  /// Error/critical status
  static const Color error = Color(0xFFF44336); // Red
  static const Color errorDark = Color(0xFFE57373);

  /// Info status
  static const Color info = Color(0xFF2196F3); // Blue
  static const Color infoDark = Color(0xFF64B5F6);

  // ============================================================================
  // NEURON STATUS COLORS
  // ============================================================================

  /// Active neuron
  static const Color neuronActive = Color(0xFF4CAF50); // Green
  static const Color neuronActiveDark = Color(0xFF81C784);

  /// Inactive neuron
  static const Color neuronInactive = Color(0xFF9E9E9E); // Gray
  static const Color neuronInactiveDark = Color(0xFFBDBDBD);

  /// Neuron with error
  static const Color neuronError = Color(0xFFF44336); // Red
  static const Color neuronErrorDark = Color(0xFFE57373);

  /// Neuron with warning
  static const Color neuronWarning = Color(0xFFFFC107); // Amber
  static const Color neuronWarningDark = Color(0xFFFFD54F);

  // ============================================================================
  // SYNAPSE SIGNAL COLORS
  // ============================================================================

  /// Excitatory signal
  static const Color signalExcitatory = Color(0xFF4CAF50); // Green
  static const Color signalExcitatoryDark = Color(0xFF81C784);

  /// Inhibitory signal
  static const Color signalInhibitory = Color(0xFFF44336); // Red
  static const Color signalInhibitoryDark = Color(0xFFE57373);

  /// Myelinated connection
  static const Color myelinated = Color(0xFFFFB300); // Gold
  static const Color myelinatedDark = Color(0xFFFFCA28);

  // ============================================================================
  // CHART COLORS
  // ============================================================================

  /// Chart color palette for data visualization
  static const List<Color> chartColors = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFFC107), // Amber
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF607D8B), // Blue Gray
  ];

  /// Chart colors for dark theme
  static const List<Color> chartColorsDark = [
    Color(0xFF64B5F6), // Light Blue
    Color(0xFF81C784), // Light Green
    Color(0xFFFFD54F), // Light Amber
    Color(0xFFF48FB1), // Light Pink
    Color(0xFFCE93D8), // Light Purple
    Color(0xFF80DEEA), // Light Cyan
    Color(0xFFFF8A65), // Light Deep Orange
    Color(0xFF90A4AE), // Light Blue Gray
  ];

  // ============================================================================
  // GLIAL CELL COLORS
  // ============================================================================

  /// Astrocyte (cache) color
  static const Color astrocyte = Color(0xFF9C27B0); // Purple
  static const Color astrocyteDark = Color(0xFFCE93D8);

  /// Oligodendrocyte (performance) color
  static const Color oligodendrocyte = Color(0xFF00BCD4); // Cyan
  static const Color oligodendrocyteDark = Color(0xFF80DEEA);

  /// Microglia (health monitoring) color
  static const Color microglia = Color(0xFFE91E63); // Pink
  static const Color microgliaDark = Color(0xFFF48FB1);

  /// Ependymal (API gateway) color
  static const Color ependymal = Color(0xFF607D8B); // Blue Gray
  static const Color ependymalDark = Color(0xFF90A4AE);

  // ============================================================================
  // UTILITY COLORS
  // ============================================================================

  /// Divider color (light)
  static const Color dividerLight = Color(0xFFE0E0E0);

  /// Divider color (dark)
  static const Color dividerDark = Color(0xFF424242);

  /// Disabled color (light)
  static const Color disabledLight = Color(0x61000000);

  /// Disabled color (dark)
  static const Color disabledDark = Color(0x61FFFFFF);

  /// Hint text color (light)
  static const Color hintLight = Color(0x99000000);

  /// Hint text color (dark)
  static const Color hintDark = Color(0x99FFFFFF);

  /// Shadow color
  static const Color shadow = Color(0x33000000);

  /// Overlay color for modals (light)
  static const Color overlayLight = Color(0x99000000);

  /// Overlay color for modals (dark)
  static const Color overlayDark = Color(0x99FFFFFF);

  // ============================================================================
  // GRADIENT COLORS
  // ============================================================================

  /// Primary gradient (light theme)
  static const LinearGradient lightPrimaryGradient = LinearGradient(
    colors: [lightPrimary, lightPrimaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Primary gradient (dark theme)
  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [darkPrimary, darkPrimaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Success gradient
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Warning gradient
  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, Color(0xFFFFCA28)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Error gradient
  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, Color(0xFFEF5350)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
