import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/colors.dart';

abstract class TextStyles {
  static TextStyle get appBarBigTextStyle {
    return TextStyle(
      color: AppColors.charcoal,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get appBarSmallTextStyle {
    return TextStyle(
      color: AppColors.charcoal,
      fontSize: 14.0,
      //fontWeight: FontWeight.w300,
    );
  }

  static TextStyle get emptyListOfDailyTasksTextStyle {
    return TextStyle(
      color: AppColors.charcoal,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get bodyTextStyle {
    return TextStyle(
        color: AppColors.charcoal, // bilo je raisinBlack
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get bodyTextStyleOnDarkerBackground =>
      bodyTextStyle.copyWith(
          color: AppColors.tealBlue,
          fontWeight: FontWeight.bold); // bilo je charcoal

  static TextStyle get whiteBodyTextStyle =>
      bodyTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w600);

  static TextStyle get mediumBodyTextStyle {
    return TextStyle(
      color: AppColors.raisinBlack,
      //color: Colors.black,
      fontSize: 16.0,
    );
  }

  static TextStyle get lightButtonTextStyle {
    return TextStyle(
      color: AppColors.charcoal,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get darkButtonTextStyle {
    return TextStyle(
      color: AppColors.gainsboro,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
