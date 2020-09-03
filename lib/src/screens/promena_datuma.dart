/*
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/src/providers/current_date_provider.dart';
import 'package:task_manager_app/src/providers/selected_date_provider.dart';

void promenaDatuma() {
  print('kako ovo jbt');
  print('Datum na pocetku: $currentDate');
  print('probacu da promenim datum');
  */
/*var nextDay = cdp.date.add(Duration(days: 1));
  cdp.date = nextDay;*//*

  currentDate.add(Duration(days: 1));
  print('posle pokusaja:');
  print('Datum sada: $currentDate');
  print('Da li se ista promenilo?');
}

class PromenaDatuma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentDateProvider = Provider.of<CurrentDateProvider>(context);
    final selectedDateProvider = Provider.of<SelectedDateProvider>(context);

    print(currentDate);

    AndroidAlarmManager.oneShot(
      Duration(minutes: 1),
      0,
      promenaDatuma,
      exact: true,
      alarmClock: true,
      wakeup: true,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.yellow[100],
        */
/*height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,*//*

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Date: $currentDate',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Selected Date: ${selectedDateProvider.date}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
