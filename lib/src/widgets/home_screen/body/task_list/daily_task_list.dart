import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/same_time_task_list.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/task_list/task_group.dart';

class DailyTaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final DateTime selectedDateTime = watch(selectedDateProvider).state;
        final DateTime currentDateTime = watch(currentDateProvider).state;

        final Stream<List<Task>> streamOfDailyTasks =
            watch(tasksDaoProvider).watchAllTasksInDay(selectedDateTime);

        final DateTime selectedDate = DateTime(selectedDateTime.year,
            selectedDateTime.month, selectedDateTime.day);
        /*final DateTime currentDate = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);
*/
        return StreamBuilder<List<Task>>(
          stream: streamOfDailyTasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Task> listOfTasks = snapshot.data;
              if (listOfTasks.isNotEmpty) {
                final List<SameTimeTaskList> formattedList =
                    dailyTaskListManipulation(listOfTasks);

                return ListView.builder(
                  itemCount: formattedList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == formattedList.length) {
                      return Container(height: 60.0);
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: TaskGroup(taskListWithTime: formattedList[index]),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: selectedDate.isBefore(
                            DateTime.now() /*currentDate was used here*/)
                        ? [
                            Text(
                              'You had no Tasks at this day.',
                              style: TextStyles.emptyListOfDailyTasksTextStyle,
                            ),
                          ]
                        : [
                            Text(
                              'You currently have no Tasks.',
                              style: TextStyles.emptyListOfDailyTasksTextStyle,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Click on Plus button to create new Task.',
                              style: TextStyles.emptyListOfDailyTasksTextStyle,
                            ),
                          ],
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                    //valueColor: AlwaysStoppedAnimation<Color>(AppColors.cadetBlue),
                    ),
              );
            }
          },
        );
      },
    );
  }
}

// TODO: posto prima sortiranu listu, ako nije u pitanju allDay task, samo zadnji indeks moze da ima isto vreme
List<SameTimeTaskList> dailyTaskListManipulation(List<Task> taskList) {
  List<SameTimeTaskList> resultList = List<SameTimeTaskList>();

  for (int i = 0; i < taskList.length; i++) {
    final Task task = taskList[i];

    if (task.allDayTask) {
      if (resultList.isEmpty) {
        resultList.add(SameTimeTaskList(null, [task]));
      } else {
        int indexOfSublistWithAllDayTasks =
            resultList.indexWhere((sublist) => sublist.time == null);
        if (indexOfSublistWithAllDayTasks != -1) {
          resultList[indexOfSublistWithAllDayTasks].taskList.add(task);
        } else {
          resultList.insert(0, SameTimeTaskList(null, [task]));
        }
      }
    } else {
      TimeOfDay tasksStartTime = TimeOfDay.fromDateTime(task.startDate);
      if (resultList.isEmpty) {
        resultList.add(SameTimeTaskList(tasksStartTime, [task]));
      } else {
        int indexOfSublistWithSameStartTime =
            resultList.indexWhere((sublist) => sublist.time == tasksStartTime);
        if (indexOfSublistWithSameStartTime != -1) {
          resultList[indexOfSublistWithSameStartTime].taskList.add(task);
        } else {
          resultList.add(SameTimeTaskList(tasksStartTime, [task]));
        }
      }
    }
  }

  return resultList;
}
