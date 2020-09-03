import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/services/notification_service.dart';
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

            //final Future<Task> futureTask = watch(tasksDaoProvider).getTask(9);

            return FutureBuilder(
              future: futureTask,
              builder: (context, AsyncSnapshot<Task> snapshot) {
                if (snapshot.data != null) {
                  final Task task = snapshot.data;
                  if (!task.completed) {
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
                          style: TextStyles.whiteBodyTextStyle
                              .copyWith(fontSize: 22.0),
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
                          // TODO:
                          // Izmeni task u bazi, cekiraj ga
                          // deaktiiraj sve notifikacije sa odgovarajucim id-em
                          // idi nazad na main
                          onPressed: () async {
                            await context
                                .read(tasksDaoProvider)
                                .updateCompleted(task);
                            var taskNotifications = await context
                                .read(notificationsDaoProvider)
                                .getTaskNotifications(task);

                            var notificationService =
                                NotificationService.instance;

                            if (taskNotifications.isNotEmpty) {
                              taskNotifications.forEach((notification) =>
                                  notificationService
                                      .cancelNotification(notification.id));
                            }

                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(height: 12.0),
                        NotificationScreenFlatButton(
                          buttonText: 'SNOOZE',
                          buttonHeight: 60.0,
                          // napravi novu notifikaciju na 5 minuta od trenutka
                          // zapravo, da li to raditi, jer ko zna kad ce se kliknuti na notifikaciju, mozda nesto kao, podseti me za 5 min ?
                          onPressed: () => print('SNOOZE'),
                        ),
                      ],
                    );
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
