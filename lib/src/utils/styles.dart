import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {
  static TextStyle textStyle(bool isDarkMode, BuildContext context) {
    final Color color =
    isDarkMode ? AppColors.textSecondary : AppColors.textPrimary;

    final double fontSize = MediaQuery.of(context).size.height / 45;

    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle clearTextStyle(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.height / 45;

    return TextStyle(
      color: AppColors.iconPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle displayTextStyle(bool isDarkMode, BuildContext context) {
    final Color color =
    isDarkMode ? AppColors.textSecondary : AppColors.textPrimary;

    return TextTheme.of(context).displayMedium!.copyWith(
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle displayIconStyle(BuildContext context) {
    return TextTheme.of(context).displayMedium!.copyWith(
      color: AppColors.iconSecondary,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle displaySubTextStyle(bool isDarkMode, BuildContext context) {
    final Color color =
    isDarkMode ? AppColors.textTertiary : AppColors.textTertiary;

    return TextTheme.of(context).displaySmall!.copyWith(
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }
}
