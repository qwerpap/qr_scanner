import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBgColor,
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBgColor,
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
