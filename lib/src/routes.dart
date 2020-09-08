import 'package:flutter/material.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/no_task_forwarded.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/screens/screens.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/task_screen':
        if (arguments is NoTaskForwarded) {
          return MaterialPageRoute(builder: (context) => NewTaskScreen());
        } else if (arguments is Task) {
          return MaterialPageRoute(
              builder: (context) => EditTaskScreen(arguments));
        }
        return _errorRoute();
      case '/reminder_screen':
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute<Reminder>(
              builder: (context) => ReminderScreen(
                  arguments['reminder'], arguments['allDayTaskReminder']));
        }
        return _errorRoute();
      case '/repeat_screen':
        return MaterialPageRoute(builder: (context) => RepeatScreen());
      case '/task_notification_screen':
        if (arguments is String) {
          return MaterialPageRoute(
              builder: (context) => TaskNotificationScreen(payload: arguments));
        }
        return _errorRoute();
      case '/home_screen':
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }

  static MaterialPageRoute _errorRoute() {
    // TODO: napraviti Error page i ovde zameniti destinaciju
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
