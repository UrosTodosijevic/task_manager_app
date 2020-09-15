import 'package:flutter/foundation.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/reminder.dart';

class TaskWithReminders {
  final Task task;
  final List<Reminder> listOfReminders;

  TaskWithReminders({
    @required this.task,
    @required this.listOfReminders,
  });
}
