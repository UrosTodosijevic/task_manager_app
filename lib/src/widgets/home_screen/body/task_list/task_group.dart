import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/core/formatting.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/same_time_task_list.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/task_list/daily_task_list.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/task_list/task_card.dart';

class TaskGroup extends StatelessWidget {
  final SameTimeTaskList taskListWithTime;

  TaskGroup({@required this.taskListWithTime});

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = taskListWithTime.time;
    List<Task> taskList = taskListWithTime.taskList;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Container(
            height: 30.0,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Text(
                time != null
                    ? '${timeNumberFormat.format(time.hour)}:${timeNumberFormat.format(time.minute)}'
                    : 'All Day Tasks',
                style: TextStyles.mediumBodyTextStyle,
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              //color: AppColors.gainsboro,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: taskList.map((task) => TaskCard(task: task)).toList(),
            ),
          ),
          SizedBox(height: 6.0),
        ],
      ),
    );
  }
}
