import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/colors.dart';

abstract class BaseStyles {
  // AppBar
  static Color get appBarBackgroundColor => AppColors.cadetBlue;

  static double get appBarElevation => 10.0;

  // Icons
  static double get iconSize => 26.0;

  static Color get iconColor => AppColors.charcoal;

  static Color get iconColorOnLight => AppColors.raisinBlack;

  // TODO: mozda izbrisati
  static IconThemeData get iconTheme =>
      IconThemeData(color: iconColor, size: iconSize);

  // Selectable Date Card
  static double selectableDateCardWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 7;
  }

  static double selectableDateCardVerticalPadding(BuildContext context){
    return MediaQuery.of(context).size.width / 7 * 0.1;
  }

  static double selectableDateCardHorizontalPadding(BuildContext context){
    return MediaQuery.of(context).size.width / 7 * 0.1;
  }
}
