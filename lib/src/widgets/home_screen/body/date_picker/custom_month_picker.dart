import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/core/utils/date_utils.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomMonthPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        monthPickerIconButton(
          context,
          iconData: Icons.arrow_back_ios,
          onPressed: () {
            final DateTime date = context.read(selectedDateProvider).state;
            context.read(selectedDateProvider).state = _previousMonth(date);
          },
        ),
        //monthPickerText(selectedDateProvider.date),
        Consumer(
          builder: (context, watch, _) {
            final DateTime selectedDate = watch(selectedDateProvider).state;
            return Text(
              DateFormat('MMMM, y').format(selectedDate).toUpperCase(),
              style: TextStyle(fontSize: 20.0),
            );
          },
        ),
        monthPickerIconButton(
          context,
          iconData: Icons.arrow_forward_ios,
          onPressed: () {
            final DateTime date = context.read(selectedDateProvider).state;
            context.read(selectedDateProvider).state = _nextMonth(date);
          },
        ),
      ],
    );
  }

  // TODO: Mozda izvuci u zaseban widget
  IconButton monthPickerIconButton(
    BuildContext context, {
    @required IconData iconData,
    @required void Function() onPressed,
  }) {
    return IconButton(
      icon: Icon(iconData),
      iconSize: ButtonStyles.iconButtonSize,
      color: ButtonStyles.iconButtonColorOnLight,
      onPressed: onPressed,
    );
  }

  DateTime _previousMonth(DateTime selectedDate) {
    final DateTime lastDayOfPreviousMonth =
        getLastDayOfPreviousMonth(selectedDate);

    return lastDayOfPreviousMonth;
  }

  DateTime _nextMonth(DateTime selectedDate) {
    final DateTime firstDayOfNextMonth = getFirstDayOfNextMonth(selectedDate);

    return firstDayOfNextMonth;
  }
}
