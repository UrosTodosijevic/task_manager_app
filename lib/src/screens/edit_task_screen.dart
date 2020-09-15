import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/models/task_with_reminders.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/widgets/edit_task_screen/edit_task_screen_app_bar.dart';
import 'package:task_manager_app/src/widgets/edit_task_screen/edit_task_screen_body.dart';

final GlobalKey<EditTaskScreenBodyState> editTaskScreenBodyStateKey =
    GlobalKey<EditTaskScreenBodyState>();

class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditTaskScreenAppBar(),
      body: Consumer(
        builder: (context, watch, _) {
          final taskNotificationsFuture =
              watch(notificationsDaoProvider).getTaskNotifications(task);

          return FutureBuilder(
            future: taskNotificationsFuture,
            builder: (context, AsyncSnapshot<List<Notification>> snapshot) {
              if (snapshot.hasData) {
                final listOfNotifications = snapshot.data;
                if (listOfNotifications.isNotEmpty) {
                  final List<Reminder> listOfReminders = _makeListOfReminders(
                      task.allDayTask, task.startDate, listOfNotifications);

                  final taskWithReminders = TaskWithReminders(
                      task: task, listOfReminders: listOfReminders);
                  return EditTaskScreenBody(
                    key: editTaskScreenBodyStateKey,
                    taskWithReminders: taskWithReminders,
                  );
                } else {
                  final taskWithReminders = TaskWithReminders(
                      task: task, listOfReminders: List<Reminder>());
                  return EditTaskScreenBody(
                    key: editTaskScreenBodyStateKey,
                    taskWithReminders: taskWithReminders,
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  List<Reminder> _makeListOfReminders(bool allDayTask,
      DateTime taskStartDateTime, List<Notification> listOfNotifications) {
    List<Reminder> _listOfReminders = List<Reminder>();
    if (allDayTask) {
      _listOfReminders.addAll(listOfNotifications
          .map((notification) => _makeReminderOutOfAllDayTaskNotification(
              taskStartDateTime, notification))
          .toList());
    } else {
      _listOfReminders.addAll(listOfNotifications
          .map((notification) =>
              _makeReminderOutOfTimeSensitiveTaskNotification(
                  taskStartDateTime, notification))
          .toList());
    }
    return _listOfReminders;
  }

  Reminder _makeReminderOutOfAllDayTaskNotification(
      DateTime taskStartDateTime, Notification notification) {
    final difference = taskStartDateTime.difference(notification.dateAndTime);
    final minutes = difference.inMinutes;
    // Day of task at 00:00
    if (minutes == 0) {
      print(ReminderForAllDayTasks());
      return ReminderForAllDayTasks();
    }
    // Day before at time
    if (minutes ~/ 1440 < 1) {
      int hoursToSubtract = minutes ~/ 60;
      int minutesToSubtract = minutes % 60;
      TimeOfDay time = TimeOfDay(
          hour: hoursToSubtract == 0
              ? 23
              : TimeOfDay.hoursPerDay - hoursToSubtract,
          minute: minutesToSubtract == 0
              ? 0
              : TimeOfDay.minutesPerHour - minutesToSubtract);
      print(ReminderForAllDayTasks(days: 1, time: time));
      return ReminderForAllDayTasks(days: 1, time: time);
    }

    // kad su custom dani i nedelje, ima problem samo sa satima
    // (dodaje 1 sat, ne znam zasto, mislio sam da je zbog vremenske zove,
    // ali ne bi trebalo da je to u pitanju jer radi dobro za 2 dana u 9h
    // i 1 nedelja u 9h
    int minutesWithAddedDay = minutes + 1440;
    int days = minutesWithAddedDay ~/ 1440;
    int leftoverMinutes = minutesWithAddedDay % 1440;

    if (days % 7 == 0) {
      int weeks = days ~/ 7;
      int hoursToSubtract = leftoverMinutes ~/ 60;
      int minutesToSubtract = leftoverMinutes % 60;
      TimeOfDay time = TimeOfDay(
          hour: hoursToSubtract == 0
              ? 23
              : TimeOfDay.hoursPerDay - hoursToSubtract,
          minute: minutesToSubtract == 0
              ? 0
              : TimeOfDay.minutesPerHour - minutesToSubtract);
      print(ReminderForAllDayTasks(weeks: weeks, time: time));
      return ReminderForAllDayTasks(weeks: weeks, time: time);
    }

    int hoursToSubtract = leftoverMinutes ~/ 60;
    int minutesToSubtract = leftoverMinutes % 60;
    TimeOfDay time = TimeOfDay(
        hour:
            hoursToSubtract == 0 ? 23 : TimeOfDay.hoursPerDay - hoursToSubtract,
        minute: minutesToSubtract == 0
            ? 0
            : TimeOfDay.minutesPerHour - minutesToSubtract);
    print(ReminderForAllDayTasks(days: days, time: time));
    return ReminderForAllDayTasks(days: days, time: time);
  }

  Reminder _makeReminderOutOfTimeSensitiveTaskNotification(
      DateTime taskStartDateTime, Notification notification) {
    final difference = taskStartDateTime.difference(notification.dateAndTime);
    final minutes = difference.inMinutes;
    // On Time task reminder
    if (minutes == 0) return ReminderForTimeSensitiveTask();
    // Weeks before
    if (minutes % 10080 == 0) {
      final weeks = minutes ~/ 10080;
      return ReminderForTimeSensitiveTask(weeks: weeks);
    }
    // Days before
    if (minutes % 1440 == 0) {
      final days = minutes ~/ 1440;
      return ReminderForTimeSensitiveTask(days: days);
    }
    // Hours before
    if (minutes % 60 == 0) {
      final hours = minutes ~/ 60;
      return ReminderForTimeSensitiveTask(hours: hours);
    }
    // Minutes before
    return ReminderForTimeSensitiveTask(minutes: minutes);
  }
}
