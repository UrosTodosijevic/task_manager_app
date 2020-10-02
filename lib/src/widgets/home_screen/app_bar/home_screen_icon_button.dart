import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;
  String tooltip;

  AppBarIconButton({
    @required this.iconData,
    @required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      iconSize: ButtonStyles.iconButtonSize,
      color: ButtonStyles.iconButtonColor,
      onPressed: onPressed,
      tooltip: tooltip != null ? tooltip : null,
    );
  }
}
