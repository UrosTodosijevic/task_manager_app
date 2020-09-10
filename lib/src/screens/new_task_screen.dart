import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/screens/repeat_screen.dart';
import 'package:task_manager_app/src/services/notification_service.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/widgets/new_task_screen/app_bar/new_task_screen_app_bar.dart';
import 'package:task_manager_app/src/widgets/new_task_screen/body/new_task_screen_body.dart';

final GlobalKey<NewTaskScreenBodyState> newTaskScreenBodyStateKey =
    GlobalKey<NewTaskScreenBodyState>();

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewTaskScreenAppBar(
          /*key */ /*newTaskScreenAppBar(context, _formKey)*/),
      body: NewTaskScreenBody(key: newTaskScreenBodyStateKey),
    );
  }

/*AppBar newTaskScreenAppBar(
      BuildContext context, GlobalKey<FormState> _formKey) {
    return AppBar(
      backgroundColor: AppColors.cadetBlue,
      automaticallyImplyLeading: false,
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                highlightColor: Colors.transparent,
                textColor: AppColors.charcoal,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Text('CANCEL', style: TextStyle(fontSize: 22.0))),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home_screen');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                highlightColor: Colors.transparent,
                textColor: AppColors.charcoal,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Text('SAVE', style: TextStyle(fontSize: 22.0))),
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _formKey.currentState
                      .reset(); // added this to clear input fields
                  //var notificationService = NotificationService.instance;
                  var notificationService =
                      context.read(notificationServiceProvider);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RepeatScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}
