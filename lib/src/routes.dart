import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/screens/birthday_notification_screen.dart';
import 'package:task_manager_app/src/screens/categories_screen.dart';
import 'package:task_manager_app/src/screens/home_screen.dart';
import 'package:task_manager_app/src/screens/new_category_screen.dart';
import 'package:task_manager_app/src/screens/new_task_screen.dart';
import 'package:task_manager_app/src/screens/reminder_screen.dart';
import 'package:task_manager_app/src/screens/repeat_screen.dart';
import 'package:task_manager_app/src/screens/task_notification_screen.dart';
import 'package:task_manager_app/src/screens/todo_list_screen.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
        //return MaterialPageRoute(builder: (context) => NewTaskScreen());
      //return MaterialPageRoute(builder: (context) => BirthdayNotificationScreen());
      //return MaterialPageRoute(builder: (context) => PromenaDatuma());
      case '/new_task_screen':
        return MaterialPageRoute(builder: (context) => NewTaskScreen());
      case '/categories_screen':
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      case '/new_category_screen':
        return MaterialPageRoute(builder: (context) => NewCategoryScreen());
      case '/todo_list_screen':
        return MaterialPageRoute(builder: (context) => TodoListScreen());
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

// homeScreen - DA
// newTaskScreen - DA
// categoriesScreen - DA
// newCategoryScreen - DA
// todoListScreen - primace argument - DA
