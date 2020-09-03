import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/base.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

abstract class ButtonStyles {
  // IconButtons
  static double get iconButtonSize => BaseStyles.iconSize;

  static Color get iconButtonColor => BaseStyles.iconColor;

  static Color get iconButtonColorOnLight => BaseStyles.iconColorOnLight;

  // Floating Action Buttons
  static Color get floatingActionButtonColor => AppColors.cadetBlue;

  static Color get floatingActionButtonIconColor => BaseStyles.iconColor;

  static double get floatingActionButtonIconSize => 30.0;

  static double bigFloatingActionButtonWidth(BuildContext context) {
    return MediaQuery.of(context).size.width *0.7;
  }

  static double get bigFloatingActionButtonHeight => 56.0;

  static TextStyle get floatingActionButtonTextStyle =>
      TextStyles.lightButtonTextStyle;
}
