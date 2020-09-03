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
  final List<Map<DateTime, List<DummyTask>>> listOfSortedDailyTasks;

  DailyTaskList(this.listOfSortedDailyTasks);

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
        final DateTime currentDate = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);

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
                    children: selectedDate.isBefore(currentDate)
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

    // Todo: ovo prekopiraj

    /*return ListView(
      children: <Widget>[
        ListView.builder(
          itemCount: listOfSortedDailyTasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: TaskGroup(
                listOfSortedDailyTasks[index].keys.first,
                listOfSortedDailyTasks[index].values.first,
              ),
            );
          },
        ),
        Container(height: 80.0),
      ],
    );*/
  }
}

class DummyTask {
  final int id;
  final String title;
  final String description;
  DateTime startDate;
  final DateTime dueDate;
  bool completed;
  final int category;

  DummyTask({
    @required this.id,
    @required this.title,
    @required this.description,
    this.startDate,
    @required this.dueDate,
    @required this.completed,
    @required this.category,
  });
}

List<DummyTask> dummyTaskList = [
  DummyTask(
      id: 1,
      title: 'Task 1',
      description: 'Description of Task 1',
      dueDate: DateTime.now().add(Duration(hours: 1)),
      completed: true,
      category: 1),
  DummyTask(
      id: 2,
      title: 'Task 2',
      description: 'Description of Task 2',
      dueDate: DateTime.now().add(Duration(hours: 1)),
      completed: false,
      category: 1),
];

List<DummyTask> dummyTaskList2 = [
  DummyTask(
      id: 3,
      title: 'Task 1 with long name, very very long name',
      description: 'Description of Task 1',
      dueDate: DateTime.now().add(Duration(hours: 2)),
      completed: true,
      category: 1),
];

List<DummyTask> dummyTaskList3 = [
  DummyTask(
      id: 4,
      title: 'Task 1',
      description: 'Description of Task 1',
      dueDate: DateTime.now().add(Duration(hours: 3)),
      completed: true,
      category: 1),
  DummyTask(
      id: 5,
      title: 'Task 2',
      description: 'Description of Task 2',
      dueDate: DateTime.now().add(Duration(hours: 3)),
      completed: false,
      category: 1),
  /*DummyTask(
      id: 3,
      title: 'Task 1',
      description: 'Description of Task 1',
      dueDate: DateTime.now().add(Duration(hours: 3)),
      completed: true,
      category: 2),*/
];

List<DummyTask> dummyTaskList4 = [
  DummyTask(
      id: 6,
      title: 'Task 1',
      description: 'Description of Task 1',
      dueDate: null,
      completed: true,
      category: 1),
  DummyTask(
      id: 7,
      title: 'Task 2',
      description: 'Description of Task 2',
      dueDate: null,
      completed: false,
      category: 1),
];

List<Map<DateTime, List<DummyTask>>> listOfSortedTasks = [
  {
    DateTime.now().add(Duration(hours: 1)): dummyTaskList,
  },
  {
    DateTime.now().add(Duration(hours: 2)): dummyTaskList2,
  },
  {
    DateTime.now().add(Duration(hours: 3)): dummyTaskList3,
  },
  {
    null: dummyTaskList4,
  }
];

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
