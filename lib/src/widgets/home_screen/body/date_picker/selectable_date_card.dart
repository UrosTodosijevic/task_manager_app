import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class SelectableDateCard extends StatelessWidget {
  final DateTime date;

  SelectableDateCard(this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: BaseStyles.selectableDateCardWidth(context),
      child: GestureDetector(
        onTap: () {
          final DateTime selectedDate =
              context.read(selectedDateProvider).state;
          if (selectedDate.day != date.day) {
            context.read(selectedDateProvider).state = date;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            dayInWeekFirstLetter(),
            SizedBox(height: 4.0),
            Expanded(
              child: Consumer(
                builder: (context, watch, _) {
                  final DateTime selectedDate =
                      watch(selectedDateProvider).state;

                  return Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 7 * 0.9,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          selectedDate.day == date.day ? Colors.red[700] : null,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: selectedDate.day == date.day
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedDate.day == date.day
                              ? Colors.white
                              : AppColors.raisinBlack,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Text dayInWeekFirstLetter() {
    return Text(DateFormat.E().format(date).substring(0, 1));
  }
}
