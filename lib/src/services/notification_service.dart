//import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/src/data/database/database.dart' as db;

class NotificationService {
  /*NotificationService._();

  static final NotificationService instance = NotificationService._();*/

  Future<void> showNotificationWithAddedOptions() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        enableLights: true,
        importance: Importance.Min,
        priority: Priority.High,
        ticker: 'tekst koji se prikazuje gore ako se iz nekog razloga '
            'notifikacija ne vidi (npr niski vaznost i prioritet, '
            'ili playSound: false)',
        playSound: false,
        enableVibration: true,
        showWhen: true);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'ovo ce biti id odgovarajuceg taska');
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        1,
        'plain title',
        'plain body plain body plain body plain body plain body ',
        platformChannelSpecifics,
        payload: '1');
  }

  Future<void> showNotificationWithNoBody() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        1, 'plain title', null, platformChannelSpecifics,
        payload: 'item x');
  }

  // Todo: razmisli o dodavanju int argumenta, za brisanje prema id
  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> rescheduleNotification(db.Task task, int notificationId) async {
    await cancelNotification(notificationId);
    await scheduleNotificationInFiveMinutes(
        task, notificationId, DateTime.now().add(Duration(minutes: 5)));
  }

  /*Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      icon: 'secondary_icon',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'schedule title',
      'schedule body',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      // ima jos bitnih opcija
      // payload
      // allow while idle
      */ /* On Android devices, the default behaviour is that the notification may not be delivered at the specified time when the device in a low-power idle mode. This behaviour can be changed by setting the optional parameter named androidAllowWhileIdle to true when calling the schedule method. */ /*
    );
  }*/

  Future<void> scheduleNotificationMyCopy() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var vibrationPattern = Int64List(4);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        ticker: 'iz nekog razloga ne pokazuje notifikaciju'
        //icon: 'secondary_icon',
        //sound: RawResourceAndroidNotificationSound('slow_spring_board'),
        //largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
        //vibrationPattern: vibrationPattern,
        );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'schedule title',
      'schedule body',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      payload: 'item x',
      androidAllowWhileIdle: true,
      // ima jos bitnih opcija
      // payload
      // allow while idle
      /* On Android devices, the default behaviour is that the notification may not be delivered at the specified time when the device in a low-power idle mode. This behaviour can be changed by setting the optional parameter named androidAllowWhileIdle to true when calling the schedule method. */
    );
  }

  Future<void> scheduleNotification(
      db.Task task, db.Notification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification channel id',
      'notification channel name',
      'notification channel description',
      ticker: task.title,
      priority: Priority.Max,
      importance: Importance.Max,
      // TODO: mozda dodati neke opcije, da notifikacija izgleda bolje
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

  Future<void> scheduleNotificationInFiveMinutes(
      db.Task task, int notificationId, DateTime newTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification channel id',
      'notification channel name',
      'notification channel description',
      ticker: task.title,
      priority: Priority.Max,
      importance: Importance.Max,
      // TODO: mozda dodati neke opcije, da notifikacija izgleda bolje
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

  Future<void> showDailyAtTime() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> showWeeklyAtDayAndTime() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        Day.Monday,
        time,
        platformChannelSpecifics);
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              '${pendingNotificationRequests.length} pending notification requests'),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showBigTextNotification() async {
    var bigTextStyleInformation = BigTextStyleInformation(
        'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        htmlFormatBigText: true,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigTextStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
}
