import 'package:flutter/material.dart';
import 'package:task_manager_app/src/data/database/database.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Edit task'),
      ),
    );
  }
}
