import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

class BirthdayNotificationScreen extends StatelessWidget {
  String _payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageBody(context),
    );
  }
}

Widget pageBody(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      color: AppColors.cadetBlue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.width * 0.08,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/birthday.png',
              height: 240.0,
            ),
            SizedBox(height: 10.0),
            Text(
              '09:57',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.gainsboro,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Sushila\'s Birthday',
              style: TextStyles.whiteBodyTextStyle,
            ),
            SizedBox(height: 4.0),
            Text(
              'Send your best wishes.',
              style: TextStyles.whiteBodyTextStyle,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: NotificationScreenFlatButton(
                    buttonText: 'CALL',
                    onPressed: () => print('CALL'),
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: NotificationScreenFlatButton(
                    buttonText: 'SMS',
                    onPressed: () => print('SMS'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            NotificationScreenFlatButton(
              buttonText: 'COMPLETED',
              buttonColor: AppColors.gainsboro,
              textColor: AppColors.cadetBlue,
              buttonHeight: 60.0,
              onPressed: () => print('COMPLETED'),
            ),
            SizedBox(height: 12.0),
            NotificationScreenFlatButton(
              buttonText: 'SNOOZE',
              buttonHeight: 60.0,
              onPressed: () => print('SNOOZE'),
            ),
          ],
        ),
      ),
    ),
  );
}

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
