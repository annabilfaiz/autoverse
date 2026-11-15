import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Semantic typography tokens for AutoVerse.
/// Strict adherence to Inter font hierarchy and 4px baseline grid.
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Inter';

  // Display: 32px / 38px, bold
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 38 / 32,
    color: AppColors.iceWhite,
    letterSpacing: -0.5,
  );

  // Headline H1: 24px / 30px, bold
  static const TextStyle headlineH1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 30 / 24,
    color: AppColors.iceWhite,
    letterSpacing: -0.3,
  );

  // Headline H2: 20px / 26px, semibold
  static const TextStyle headlineH2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 26 / 20,
    color: AppColors.iceWhite,
    letterSpacing: -0.2,
  );

  // Headline H3: 16px / 22px, semibold
  static const TextStyle headlineH3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
    color: AppColors.iceWhite,
  );

  // Body: 14px / 20px, regular
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.iceWhite,
  );

  // Body Strong: 14px / 20px, semibold
  static const TextStyle bodyStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    color: AppColors.iceWhite,
  );

  // Caption: 12px / 16px, regular
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.titanium,
  );

  // Micro: 10px / 14px, medium
  static const TextStyle micro = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 14 / 10,
    color: AppColors.mutedSteel,
    letterSpacing: 0.2,
  );

  // Button: 14px / 18px, semibold
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 18 / 14,
    color: AppColors.iceWhite,
  );
}
