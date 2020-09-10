import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/src/data/database/database.dart' as db;
import 'package:task_manager_app/src/providers.dart';

class NotificationService {
  Future<void> scheduleNotification(
      db.Task task, db.Notification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification channel id',
      'notification channel name',
      'notification channel description',
      ticker: task.title,
      priority: Priority.Max,
      importance: Importance.Max,
      // TODO: mozda dodati neke opcije, da notifikacija izgleda bolje,
      // TODO: npr. ikonicu aplikacije, u svakom slucaju pogledati dokumentaciju
    );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.schedule(
      notification.id,
      task.title,
      task.notes ?? '',
      notification.dateAndTime,
      platformChannelSpecifics,
      payload: notification.id.toString(),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleNotificationUsingIds(
      int taskId, int notificationId) async {
    final container = ProviderContainer();
    final task = await container.read(tasksDaoProvider).getTask(taskId);
    final notification = await container
        .read(notificationsDaoProvider)
        .getNotification(notificationId);
    await scheduleNotification(task, notification);
  }

  Future<void> scheduleInsistentNotification(
      db.Task task, db.Notification notification) async {
    var insistentFlag = 4;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification channel id',
      'notification channel name',
      'notification channel description',
      ticker: task.title,
      importance: Importance.Max,
      priority: Priority.High,
      additionalFlags: Int32List.fromList([insistentFlag]),
    );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.schedule(
      notification.id,
      task.title,
      task.notes ?? '',
      notification.dateAndTime,
      platformChannelSpecifics,
      payload: notification.id.toString(),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> rescheduleNotification(db.Task task, int notificationId) async {
    await cancelNotification(notificationId);
    await _scheduleNotificationInFiveMinutes(
        task, notificationId, DateTime.now().add(Duration(minutes: 5)));
  }

  Future<void> _scheduleNotificationInFiveMinutes(
      db.Task task, int notificationId, DateTime newTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification channel id',
      'notification channel name',
      'notification channel description',
      ticker: task.title,
      priority: Priority.Max,
      importance: Importance.Max,
    );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.schedule(
      notificationId,
      task.title,
      task.notes ?? '',
      newTime,
      platformChannelSpecifics,
      payload: notificationId.toString(),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
