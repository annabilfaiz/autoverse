import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.voidBlack,
      primaryColor: AppColors.performanceLime,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.performanceLime,
        onPrimary: AppColors.voidBlack,
        surface: AppColors.carbon,
        onSurface: AppColors.iceWhite,
        error: AppColors.error,
        onError: AppColors.voidBlack,
      ),
      fontFamily: AppTypography.fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: AppColors.iceWhite),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.carbon,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppColors.carbon,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.steel,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
