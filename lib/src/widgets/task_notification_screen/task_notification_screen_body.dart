import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/task_notification_screen/task_notification_screen_widgets.dart';

class TaskNotificationScreenBody extends StatelessWidget {
  final String payload;

  TaskNotificationScreenBody(this.payload);

  @override
  Widget build(BuildContext context) {
    final notificationId = int.tryParse(payload);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColors.cadetBlue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.width * 0.08,
        ),
        child: Consumer(
          builder: (context, watch, _) {
            final Future<Task> futureTask = watch(tasksDaoProvider)
                .getTaskUsingNotificationId(notificationId);

            return FutureBuilder(
              future: futureTask,
              builder: (context, AsyncSnapshot<Task> snapshot) {
                if (snapshot.data != null) {
                  final Task task = snapshot.data;
                  if (!task.completed) {
                    return ActiveTaskMessage(task, notificationId);
                  } else {
                    return TaskAlreadyCompletedMessage();
                  }
                } else {
                  return TaskAlreadyDeletedMessage();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
