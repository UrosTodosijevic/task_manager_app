import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class NotificationScreenFlatButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final double borderWidth;
  final Color textColor;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback onPressed;

  NotificationScreenFlatButton({
    @required this.buttonText,
    this.buttonHeight = 40.0,
    this.buttonWidth,
    this.borderWidth = 2.0,
    this.textColor = Colors.white,
    this.buttonColor = Colors.transparent,
    borderColor,
    @required this.onPressed,
  }) : borderColor = buttonColor == Colors.transparent
            ? AppColors.gainsboro
            : buttonColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(buttonHeight / 2),
      ),
      child: Container(
        height: buttonHeight,
        /*width: buttonWidth != null
            ? buttonWidth
            : MediaQuery.of(context).size.width,*/
        alignment: Alignment.center,
        child: Text(buttonText, style: TextStyle(fontSize: 22.0)),
      ),
      onPressed: onPressed,
    );
  }
}
