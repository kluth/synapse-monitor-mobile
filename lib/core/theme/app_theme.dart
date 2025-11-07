import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Application theme configuration.
///
/// Provides light and dark themes with consistent styling across the app.
class AppTheme {
  AppTheme._();

  // ============================================================================
  // LIGHT THEME
  // ============================================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      floatingActionButtonTheme: _lightFabTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      chipTheme: _lightChipTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _lightDividerTheme,
      iconTheme: _lightIconTheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
    );
  }

  static final ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightOnPrimary,
    secondary: AppColors.lightSecondary,
    onSecondary: AppColors.lightOnSecondary,
    error: AppColors.lightError,
    onError: AppColors.lightOnError,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
  );

  static final AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.lightPrimary,
    foregroundColor: AppColors.lightOnPrimary,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(
      color: AppColors.lightOnPrimary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.lightOnPrimary,
    ),
  );

  static const InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.dividerLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.dividerLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.lightPrimary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.lightError),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: TextStyle(color: AppColors.hintLight),
    labelStyle: AppTextStyles.inputLabel,
  );

  static final FloatingActionButtonThemeData _lightFabTheme =
      FloatingActionButtonThemeData(
    backgroundColor: AppColors.lightSecondary,
    foregroundColor: AppColors.lightOnSecondary,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static final BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.lightPrimary,
    unselectedItemColor: AppColors.hintLight,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: AppTextStyles.labelSmall,
    unselectedLabelStyle: AppTextStyles.labelSmall,
  );

  static final ChipThemeData _lightChipTheme = ChipThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedColor: AppColors.lightPrimary,
    disabledColor: AppColors.disabledLight,
    labelStyle: AppTextStyles.labelMedium,
    brightness: Brightness.light,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static const DividerThemeData _lightDividerTheme = DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: 1,
  );

  static const IconThemeData _lightIconTheme = IconThemeData(
    color: AppColors.lightOnSurface,
    size: 24,
  );

  // ============================================================================
  // DARK THEME
  // ============================================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      floatingActionButtonTheme: _darkFabTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      chipTheme: _darkChipTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _darkDividerTheme,
      iconTheme: _darkIconTheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }

  static final ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
  );

  static final AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkOnSurface,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(
      color: AppColors.darkOnSurface,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkOnSurface,
    ),
  );

  static const InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.dividerDark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.dividerDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.darkPrimary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.darkError),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    hintStyle: TextStyle(color: AppColors.hintDark),
    labelStyle: AppTextStyles.inputLabel,
  );

  static final FloatingActionButtonThemeData _darkFabTheme =
      FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkSecondary,
    foregroundColor: AppColors.darkOnSecondary,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static final BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.darkPrimary,
    unselectedItemColor: AppColors.hintDark,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: AppTextStyles.labelSmall,
    unselectedLabelStyle: AppTextStyles.labelSmall,
  );

  static final ChipThemeData _darkChipTheme = ChipThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedColor: AppColors.darkPrimary,
    disabledColor: AppColors.disabledDark,
    labelStyle: AppTextStyles.labelMedium,
    brightness: Brightness.dark,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static const DividerThemeData _darkDividerTheme = DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 1,
  );

  static const IconThemeData _darkIconTheme = IconThemeData(
    color: AppColors.darkOnSurface,
    size: 24,
  );

  // ============================================================================
  // SHARED THEME COMPONENTS
  // ============================================================================

  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  static final CardTheme _cardTheme = CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      textStyle: AppTextStyles.button,
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: AppTextStyles.button,
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: AppTextStyles.button,
    ),
  );

  static final DialogTheme _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 8,
    titleTextStyle: AppTextStyles.titleLarge,
    contentTextStyle: AppTextStyles.bodyMedium,
  );
}
