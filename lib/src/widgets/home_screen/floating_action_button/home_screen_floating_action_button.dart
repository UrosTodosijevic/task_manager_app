import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class HomeScreenFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final DateTime selectedDateTime = watch(selectedDateProvider).state;
        final DateTime currentDateTime = watch(currentDateProvider).state;
        final DateTime selectedDate = DateTime(selectedDateTime.year,
            selectedDateTime.month, selectedDateTime.day);
        final DateTime currentDate = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);

        return !selectedDate.isBefore(currentDate)
            ? FloatingActionButton(
                tooltip: 'New Task',
                backgroundColor: ButtonStyles.floatingActionButtonColor,
                child: Icon(
                  Icons.add,
                  size: ButtonStyles.floatingActionButtonIconSize,
                  color: ButtonStyles.floatingActionButtonIconColor,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/new_task_screen'),
              )
            : SizedBox.shrink();
      },
    );
  }
}
