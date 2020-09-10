import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/models/time_interval.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

class ReminderScreen extends StatefulWidget {
  final Reminder _reminder;
  final bool _allDayTaskReminder;

  ReminderScreen(this._reminder, this._allDayTaskReminder);

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  Reminder reminder;
  bool allDayTaskReminderType;

  List<Reminder> reminderList;

  int selectedIndex;
  int backupIndex;

  @override
  void initState() {
    super.initState();
    reminder = widget._reminder;
    allDayTaskReminderType = widget._allDayTaskReminder;
    reminderList = initializeReminderList();
    selectedIndex = insertTaskIntoReminderList();
    backupIndex = selectedIndex;
  }

  List<Reminder> initializeReminderList() {
    if (allDayTaskReminderType) {
      return List<ReminderForAllDayTasks>()
        ..addAll(defaultRemindersForAllDayTasks);
    } else {
      return List<ReminderForTimeSensitiveTask>()
        ..addAll(defaultRemindersForTimeSensitiveTasks);
    }
  }

  int insertTaskIntoReminderList() {
    if (reminder != null) {
      if (reminderList.contains(reminder)) {
        return reminderList.indexOf(reminder);
      }

      int indexOfElementWithSameToMinutesValue = reminderList
          .indexWhere((element) => element.toMinutes == reminder.toMinutes);
      if (indexOfElementWithSameToMinutesValue == -1) {
        reminderList
          ..add(reminder)
          ..sort();
        return reminderList.indexOf(reminder);
      } else {
        return indexOfElementWithSameToMinutesValue;
      }
    }
    return -1;
  }

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  Future<Reminder> _showCustomizationDialog() async {
    return showDialog<Reminder>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomizationDialog(allDayTaskReminderType);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cadetBlue,
        automaticallyImplyLeading: true,
        title: Text('Reminder', style: TextStyles.appBarBigTextStyle),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: reminderList.length + 1,
        separatorBuilder: (context, index) => Divider(
          height: 2.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == reminderList.length) {
            /*
            TODO:
             * dodati selected customize bool
             * inizijalizovati ga
             * zapamtiti selected index u rezervnoj promenljivoj da bi mogao da se vrati ako customize deo vrati null (odustane se od izbora)
            */

            return InkWell(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      (index == selectedIndex)
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 24.0,
                      color: (index == selectedIndex)
                          ? AppColors.cadetBlue
                          : Colors.grey[600],
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      'Customize',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                setState(() {
                  selectedIndex = index;
                });
                final returnedReminder = await _showCustomizationDialog();
                if (returnedReminder != null) {
                  Navigator.of(context).pop(returnedReminder);
                }
                setState(() {
                  selectedIndex = backupIndex;
                });
              },
            );
          }
          return InkWell(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    (index == selectedIndex)
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 24.0,
                    color: (index == selectedIndex)
                        ? AppColors.cadetBlue
                        : Colors.grey[600],
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    reminderList[index].toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              Navigator.of(context).pop(reminderList[index]);
            },
          );
        },
      ),
    );
  }
}

// TODO: MOZDA PROMENITI IME U ReminderCustomizationDialog ako i za repeat opcije budem koristio CustomizationDialog
class CustomizationDialog extends StatefulWidget {
  final bool allDayTaskReminderType;

  CustomizationDialog(this.allDayTaskReminderType);

  @override
  _CustomizationDialogState createState() => _CustomizationDialogState();
}

class _CustomizationDialogState extends State<CustomizationDialog> {
  bool _allDayTaskReminder;

  TimeInterval _timeInterval;
  List<TimeInterval> _listOfTimeInterval;

  TextEditingController _controller;

  bool _enableDone;

  TimeOfDay _timeOfDay;

  void initState() {
    super.initState();
    _allDayTaskReminder = widget.allDayTaskReminderType;
    _timeInterval = _allDayTaskReminder ? TimeInterval.day : TimeInterval.min;
    _listOfTimeInterval = _allDayTaskReminder
        ? [TimeInterval.day, TimeInterval.week]
        : TimeInterval.values;
    _controller = TextEditingController(text: '10');
    _enableDone = true;
    _timeOfDay = TimeOfDay(hour: 9, minute: 0);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('00');

    return AlertDialog(
      title: Text('Reminder'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value == '') {
                        setState(() {
                          _enableDone = false;
                        });
                      } else if (!_enableDone) {
                        setState(() {
                          _enableDone = true;
                        });
                      }
                    },
                    cursorColor: AppColors.cadetBlue,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 10.0),
                DropdownButton<TimeInterval>(
                  value: _timeInterval,
                  items: _listOfTimeInterval
                      .map<DropdownMenuItem<TimeInterval>>(
                          (interval) => DropdownMenuItem(
                                value: interval,
                                child: Text(
                                  timeIntervalInBeforeFormat(interval),
                                ),
                              ))
                      .toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (TimeInterval newValue) {
                    setState(() {
                      _timeInterval = newValue;
                    });
                  },
                  underline: Container(),
                ),
              ],
            ),
            _allDayTaskReminder ? SizedBox(height: 10.0) : SizedBox.shrink(),
            _allDayTaskReminder
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text(
                          'Change Time',
                          style: TextStyle(
                              color: AppColors.cadetBlue, fontSize: 16.0),
                        ),
                        color: /*Colors.grey[300]*/ AppColors.beauBlue,
                        onPressed: () async {
                          final returnedTime = await showTimePicker(
                            context: context,
                            initialTime: _timeOfDay,
                            initialEntryMode: TimePickerEntryMode.input,
                          );
                          if (returnedTime != null &&
                              (returnedTime.hour != _timeOfDay.hour ||
                                  returnedTime.minute != _timeOfDay.minute)) {
                            setState(() {
                              _timeOfDay = returnedTime;
                            });
                          }
                        },
                      ),
                      SizedBox(width: 30.0),
                      Text(
                          '${numberFormat.format(_timeOfDay.hour)} : ${numberFormat.format(_timeOfDay.minute)}',
                          style: /*TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),*/ TextStyles
                              .bodyTextStyle),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(color: AppColors.cadetBlue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('DONE'),
          textColor: AppColors.cadetBlue,
          disabledTextColor: Colors.grey[600],
          onPressed: _enableDone
              ? () {
                  final customReminder = makeReminder();
                  Navigator.of(context).pop<Reminder>(customReminder);
                }
              : null,
        ),
      ],
    );
  }

  Reminder makeReminder() {
    if (_allDayTaskReminder) {
      final parsedNumber = int.parse(_controller.text);
      ReminderForAllDayTasks customReminder;
      if (_timeInterval == TimeInterval.day) {
        customReminder =
            ReminderForAllDayTasks(days: parsedNumber, time: _timeOfDay);
      } else {
        /* in this case _timeInterval will be TimeInterval.week,
        that is hard coded in listOfTimeIntervals which is used to make
        options for dropdown button */
        customReminder =
            ReminderForAllDayTasks(weeks: parsedNumber, time: _timeOfDay);
      }
      return customReminder;
    } else {
      final parsedNumber = int.parse(_controller.text);
      ReminderForTimeSensitiveTask customReminder;
      switch (_timeInterval) {
        case TimeInterval.min:
          customReminder = ReminderForTimeSensitiveTask(minutes: parsedNumber);
          break;
        case TimeInterval.hour:
          customReminder = ReminderForTimeSensitiveTask(hours: parsedNumber);
          break;
        case TimeInterval.day:
          customReminder = ReminderForTimeSensitiveTask(days: parsedNumber);
          break;
        case TimeInterval.week:
          customReminder = ReminderForTimeSensitiveTask(weeks: parsedNumber);
          break;
      }
      return customReminder;
    }
  }
}
