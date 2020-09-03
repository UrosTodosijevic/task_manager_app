import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/date_picker/scrollable_date_picker.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/task_list/daily_task_list.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.beauBlue,
      child: Column(
        children: <Widget>[
          ScrollableDatePicker(),
          SizedBox(height: 2.0),
          Expanded(
            child: DailyTaskList(listOfSortedTasks),
          ),
        ],
      ),
    );
  }
}
