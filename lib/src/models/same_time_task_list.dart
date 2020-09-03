import 'package:flutter/material.dart';
import 'package:task_manager_app/src/data/database/database.dart';

class SameTimeTaskList {
  TimeOfDay time;
  List<Task> taskList;

  SameTimeTaskList(this.time, this.taskList);
}
