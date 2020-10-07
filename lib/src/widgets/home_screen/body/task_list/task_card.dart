import 'package:flutter/material.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/task_option.dart';
import 'package:task_manager_app/src/models/task_option_popup_menu_item.dart';
import 'package:task_manager_app/src/models/task_to_copy.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/task_list/daily_task_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // Todo: izbaciti color atribut ako ne zelim da menjam boju kartice zavisno od toga da li je task izvrsen
        color:
            task.completed == true ? AppColors.gainsboro : AppColors.gainsboro,
        border: Border.all(
            width: 1.0, color: /*Colors.grey[300]*/ AppColors.beauBlue),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Checkbox(
            value: task.completed,
            activeColor: AppColors.cadetBlue,
            checkColor: Colors.white,
            onChanged: (value) async {
              // TODO: proveriti da li je ovo await potrebno
              await context.read(tasksDaoProvider).updateCompleted(task);
            },
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(task.title,
                    overflow: TextOverflow.ellipsis,
                    style: task.completed == true
                        ? TextStyles.bodyTextStyleOnDarkerBackground
                        : TextStyles.bodyTextStyle),
                SizedBox(height: 6.0),
                // TODO: napraviti da ima overdue, currently, upcoming/description
                // TODO: videti sta ce da se desi ako je viseredni, postaviti overflow parametar
                task.notes != null
                    ? Text(
                        task.notes,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyles.mediumBodyTextStyle,
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Consumer(
            builder: (context, watch, child) {
              final selectedDateTime = watch(selectedDateProvider).state;
              final selectedDate = DateTime(selectedDateTime.year,
                  selectedDateTime.month, selectedDateTime.day);
              final now = DateTime.now();
              final nowJustDate = DateTime(now.year, now.month, now.day);

              return PopupMenuButton<TaskOption>(
                icon: Icon(Icons.more_vert),
                color: AppColors.gainsboro,
                // TODO: videti da li je potrebno koristiti consumer zbog toga gde citam selectedDate, odnosi se na ovo iznad (vec je dodat)
                itemBuilder: (BuildContext context) {
                  return selectedDate.isBefore(nowJustDate)
                      ? <PopupMenuEntry<TaskOption>>[
                          popupMenuItemDelete,
                          popupMenuItemCopy,
                        ]
                      : <PopupMenuEntry<TaskOption>>[
                          popupMenuItemEdit,
                          popupMenuItemDelete,
                        ];
                },
                onSelected: (TaskOption result) {
                  if (result == TaskOption.edit) {
                    print('Edit Task, soon...');
                    Navigator.of(context)
                        .pushNamed('/task_screen', arguments: task);
                  }
                  if (result == TaskOption.copy) {
                    print('Copy Task, soon...');
                    Navigator.of(context).pushNamed('/task_screen',
                        arguments: TaskToCopy(task: task));
                  }
                  if (result == TaskOption.delete) {
                    print('Delete Task, soon...');
                    // Also turns off all scheduled notification for this task
                    context.read(tasksDaoProvider).deleteTask(task);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
