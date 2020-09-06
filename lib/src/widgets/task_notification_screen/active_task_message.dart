import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/services/notification_service.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/widgets/task_notification_screen/task_notification_screen_widgets.dart';

class ActiveTaskMessage extends StatelessWidget {
  final Task task;
  final int notificationId;

  const ActiveTaskMessage(this.task, this.notificationId);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/to_do_list.png',
          height: 200.0,
        ),
        SizedBox(height: 20.0),
        Text(
          'Start at: ${DateFormat.Hm().format(task.startDate)}',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.gainsboro,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          task.title,
          style: TextStyles.whiteBodyTextStyle.copyWith(fontSize: 22.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.0),
        Text(
          task.notes ?? '',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.gainsboro,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 30.0),
        NotificationScreenFlatButton(
          buttonText: 'COMPLETED',
          buttonColor: AppColors.gainsboro,
          textColor: AppColors.cadetBlue,
          buttonHeight: 60.0,
          onPressed: () async {
            await context.read(tasksDaoProvider).updateCompleted(task);
            final taskNotifications = await context
                .read(notificationsDaoProvider)
                .getTaskNotifications(task);
            final NotificationService notificationService =
                context.read(notificationServiceProvider);

            if (taskNotifications.isNotEmpty) {
              taskNotifications.forEach((notification) =>
                  notificationService.cancelNotification(notification.id));
            }
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: 12.0),
        NotificationScreenFlatButton(
          buttonText: 'SNOOZE',
          buttonHeight: 60.0,
          onPressed: () async {
            print('SNOOZE');
            final NotificationService notificationService =
                context.read(notificationServiceProvider);
            await notificationService.rescheduleNotification(
                task, notificationId);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
