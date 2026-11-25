import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const title = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );

  static const caption = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );
  static const micro = TextStyle(
    fontSize: 9,
    color: AppColors.textMuted,
  );

  static const overline = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.6,
    color: AppColors.accent,
  );

  static const screenLabel = TextStyle(
    fontSize: 8,
    letterSpacing: 3,
    color: AppColors.textMuted,
  );

  static const chip = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const chipTag = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w700,
  );

  static const rowLetter = TextStyle(
    fontSize: 9,
    color: AppColors.textMuted,
  );

  static const seatNumber = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w700,
    color: AppColors.onAccent,
  );

  static const price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const seatTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const statValue = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const pill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}
