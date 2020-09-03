import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_manager_app/src/app.dart';
import 'package:task_manager_app/src/providers/current_date_provider.dart';

/*CurrentDateProvider cdp = CurrentDateProvider();

DateTime currentDate = DateTime.now();*/

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();*/

  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initializationSettings =
      InitializationSettings(initializationSettingsAndroid, null);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectNotificationSubject.add(payload);
  });

  var nulaNula = DateTime(2020, 8, 31, 0, 0);
  var nulaJedan = DateTime(2020, 8, 31, 0, 1);
  var minutDoPonoci = DateTime(2020, 8, 31, 23, 59);
  var ponoc = DateTime(2020, 8, 31, 23, 60);

  print('--------------------------------------');
  print('nula nula: $nulaNula');
  print('nula jedan: $nulaJedan');
  print('minut do ponoci: $minutDoPonoci');
  print('ponoc: $ponoc');
  print('--------------------------------------');

  runApp(ProviderScope(
    child: App(),
  ));
}
