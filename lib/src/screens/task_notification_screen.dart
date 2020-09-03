import 'package:flutter/material.dart';
import 'package:task_manager_app/src/widgets/task_notification_screen/task_notification_screen_widgets.dart';

class TaskNotificationScreen extends StatelessWidget {
  final String payload;

  TaskNotificationScreen({this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskNotificationScreenBody(payload),
    );
  }
}
