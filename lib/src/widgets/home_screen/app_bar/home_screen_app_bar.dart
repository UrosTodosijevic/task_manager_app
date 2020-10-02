import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/services/notification_service.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/app_bar/home_screen_icon_button.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BaseStyles.appBarBackgroundColor,
      elevation: BaseStyles.appBarElevation,
      centerTitle: true,
      title: Column(
        children: <Widget>[
          Text('MY TASKS FOR', style: TextStyles.appBarBigTextStyle),
          Consumer(
            builder: (context, watch, child) {
              var selectedDate = watch(selectedDateProvider).state;
              return Text(
                DateFormat.yMMMMEEEEd().format(selectedDate),
                style: TextStyles.appBarSmallTextStyle,
              );
            },
          ),
        ],
      ),
      leading: AppBarIconButton(
        iconData: Icons.dehaze,
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'This feature will be added in the next version of Task Manage application.'),
            ),
          );
        },
      ),
      actions: <Widget>[
        AppBarIconButton(
          iconData: Icons.search,
          onPressed: () async {
            //1.  print('SOON...');
            /*2.  var date = context.read(selectedDateProvider).state;
            context.read(selectedDateProvider).state =
                date.add(Duration(days: -1));*/
            final napravljeniTaskCompanion = TasksCompanion(
              title: Value('Demonstration task'),
              allDayTask: Value(false),
              completed: Value(false),
              notes: Value('This is task made for demonstration purposes'),
              startDate: Value(DateTime.now().add(Duration(minutes: 5))),
              endDate: Value(DateTime.now().add(Duration(minutes: 10))),
            );

            final int taskId = await context
                .read(tasksDaoProvider)
                .insertTask(napravljeniTaskCompanion);

            final napravljeniNotificationCompanion = NotificationsCompanion(
              dateAndTime: Value(DateTime.now().add(Duration(seconds: 15))),
              taskId: Value(taskId),
            );

            var notificationId = await context
                .read(notificationsDaoProvider)
                .insertNotification(napravljeniNotificationCompanion);

            var task = await context.read(tasksDaoProvider).getTask(taskId);
            var notification = await context
                .read(notificationsDaoProvider)
                .getNotification(notificationId);

            await context
                .read(notificationServiceProvider)
                .scheduleNotification(task, notification);

            // Druga notifikacija

            final napravljeniNotificationCompanion2 = NotificationsCompanion(
              dateAndTime: Value(DateTime.now().add(Duration(seconds: 35))),
              taskId: Value(taskId),
            );

            var notificationId2 = await context
                .read(notificationsDaoProvider)
                .insertNotification(napravljeniNotificationCompanion2);

            var notification2 = await context
                .read(notificationsDaoProvider)
                .getNotification(notificationId2);

            await context
                .read(notificationServiceProvider)
                .scheduleInsistentNotification(task, notification2);

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('For demonstration purposes added new Task '
                    'with Notifications. Search feature will be added in '
                    'the next version of Task Manage application.'),
              ),
            );
          },
        ),
        AppBarIconButton(
          iconData: Icons.refresh,
          onPressed: () => context.read(selectedDateProvider).state =
              context.read(currentDateProvider).state,
          tooltip: 'Today',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
