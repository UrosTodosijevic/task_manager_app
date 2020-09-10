import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewTaskScreenBody extends StatefulWidget {
  NewTaskScreenBody({Key key}) : super(key: key);

  @override
  NewTaskScreenBodyState createState() => NewTaskScreenBodyState();
}

class NewTaskScreenBodyState extends State<NewTaskScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;

  // DateTime variables
  bool _allDay;

  DateTime _startDate;
  DateTime _endDate;
  TimeOfDay _currentStartTime;
  TimeOfDay _currentEndTime;

  // Notification variables
  bool _useNotifications;
  List<ReminderForTimeSensitiveTask> timeSensitiveTaskReminders;
  List<ReminderForAllDayTasks> allDayTaskReminders;

  List<Reminder> _listOfReminders;

  // TODO:
  // Repeat variables
  bool _repeatingTask;

  // Notes variables
  bool _hasNote;
  String _notesText;

  // TODO: kad ovaj widget prepravim u visenamensko telo task (new/edit)
  //  ekrana, treba promeniti inicijalizaciju tako da se ili daje vrednost iz
  //  konstruktora ili postavlja kao prazan string.
  String taskDescription = '';

  @override
  void initState() {
    _title = '';

    _startDate =
        DateTime.now().add(Duration(hours: 1, minutes: -DateTime.now().minute));
    _endDate =
        DateTime.now().add(Duration(hours: 2, minutes: -DateTime.now().minute));
    _currentStartTime = TimeOfDay.fromDateTime(_startDate);
    _currentEndTime = TimeOfDay.fromDateTime(_endDate);

    _allDay = false;
    _useNotifications = false;

    // TODO: ovo ce verovatno biti izbaceno
    timeSensitiveTaskReminders = List<ReminderForTimeSensitiveTask>()
      ..add(tenMinutesBefore)
      ..add(oneHourBefore)
      ..add(ReminderForTimeSensitiveTask(minutes: 60));

    // TODO: ovo ce verovatno biti izbaceno
    allDayTaskReminders = List<ReminderForAllDayTasks>()
      ..add(day_before_17h)
      ..add(day_of_00h);

    // TODO: ovo ce verovatno biti zadrzano
    setListOfReminders();

    _repeatingTask = false;

    _hasNote = false;
    _notesText = '';

    super.initState();
  }

  void setListOfReminders() {
    if (_allDay) {
      _listOfReminders = List<ReminderForAllDayTasks>()
        ..add(day_of_00h)
        ..add(day_before_17h);
    } else {
      _listOfReminders = List<ReminderForTimeSensitiveTask>()
        ..add(tenMinutesBefore)
        //..add(oneHourBefore)
        ..add(ReminderForTimeSensitiveTask(minutes: 60))
        ..add(oneWeekBefore);
    }
  }

  Future<DateTime> _selectDate(
      BuildContext context, DateTime initialDate, DateTime firstDate) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: DateTime(2022));
    return pickedDate;
  }

  Future<TimeOfDay> _selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    final pickedTime = await showTimePicker(
      //initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: initialTime,
    );
    return pickedTime;
  }

  Future<bool> tryToEnterNewTask() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final task = TasksCompanion(
        title: Value(_title),
        allDayTask: Value(_allDay),
        startDate: Value(_startDate),
        endDate: Value(_endDate),
        notes: _hasNote ? Value(_notesText) : Value.absent(),
      );

      int taskId = await context.read(tasksDaoProvider).insertTask(task);

      if (_useNotifications && _listOfReminders.isNotEmpty) {
        _listOfReminders.forEach((reminder) async {
          final notification = NotificationsCompanion(
            dateAndTime: Value(reminder.notificationDateTime(_startDate)),
            taskId: Value(taskId),
          );

          int notificationId = await context
              .read(notificationsDaoProvider)
              .insertNotification(notification);

          await context
              .read(notificationServiceProvider)
              .scheduleNotificationUsingIds(taskId, notificationId);
        });
      }

      _formKey.currentState.reset(); // added this to clear input fields

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Omogucava da se iz input fielda izadje klikom bilo gde na ekranu
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.gainsboro,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'New Task Name...',
                    hintStyle: TextStyle(fontSize: 20.0),
                  ),
                  cursorWidth: 3.0,
                  cursorColor: AppColors.cadetBlue,
                  maxLength: 32,
                  style: TextStyle(fontSize: 20.0),
                  validator: (String value) =>
                      value.isEmpty ? 'Task name is required' : null,
                  onSaved: (String value) {
                    setState(() {
                      _title = value;
                    });
                  },
                ),
                //SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.access_time),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'All day',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch(
                        value: _allDay,
                        activeColor: AppColors.cadetBlue,
                        activeTrackColor: AppColors.tealBlue,
                        inactiveThumbColor: AppColors.lightPeriwinkle,
                        inactiveTrackColor: AppColors.cadetBlue,
                        onChanged: (bool newValue) {
                          //resetNotificationLists();
                          if (newValue == true) {
                            setState(() {
                              _endDate = DateTime(
                                _startDate.year,
                                _startDate.month,
                                _startDate.day,
                                _currentEndTime.hour,
                                _currentEndTime.minute,
                              );
                              _allDay = newValue;
                              setListOfReminders();
                            });
                          } else {
                            setState(() {
                              _allDay = newValue;
                              setListOfReminders();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Start',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        FlatButton(
                          clipBehavior: Clip.antiAlias,
                          splashColor: AppColors.darkSkyBlue,
                          highlightColor: Colors.transparent,
                          color: AppColors.lightPeriwinkle,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, color: AppColors.cadetBlue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: Text(
                              _allDay == true
                                  ? DateFormat('E, MMM d, y').format(_startDate)
                                  : DateFormat('E, MMM d, y HH:mm')
                                      .format(_startDate),
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_allDay) {
                              var pickedDate = await _selectDate(
                                  context, _startDate, DateTime.now());
                              if (pickedDate != null) {
                                setState(() {
                                  _startDate = pickedDate.add(Duration(
                                      hours: _currentStartTime.hour,
                                      minutes: _currentStartTime.minute));
                                  _endDate = pickedDate.add(Duration(
                                      hours: _currentEndTime.hour,
                                      minutes: _currentEndTime.minute));
                                });
                              }
                            } else {
                              var pickedDate = await _selectDate(
                                  context, _startDate, DateTime.now());
                              if (pickedDate == null) return;
                              final pickedTime =
                                  await _selectTime(context, _currentStartTime);
                              if (pickedTime == null) return;
                              var now = DateTime.now();
                              var currentDate =
                                  DateTime(now.year, now.month, now.day);
                              var currentTime = TimeOfDay.now();

                              if (pickedDate.isAfter(currentDate) ||
                                  pickedTime.hour > currentTime.hour ||
                                  (pickedTime.hour == currentTime.hour &&
                                      pickedTime.minute > currentTime.minute)) {
                                DateTime newStartDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute);
                                /*
                                does not work as planed when newStartDateTime
                                has everything same, because of the way
                                startDate is initialized at beginning (seconds
                                and milliseconds are not subtract from .now()
                                 */
                                if (newStartDateTime.compareTo(_endDate) < 0) {
                                  setState(() {
                                    _startDate = newStartDateTime;
                                    _currentStartTime = pickedTime;
                                  });
                                } else {
                                  DateTime newEndDateTime = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                      pickedTime.hour + 1,
                                      pickedTime.minute);
                                  setState(() {
                                    _startDate = newStartDateTime;
                                    _endDate = newEndDateTime;
                                    _currentStartTime = pickedTime;
                                    _currentEndTime =
                                        TimeOfDay.fromDateTime(newEndDateTime);
                                  });
                                }
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('Can not schedule tasks in past...'),
                                ));
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'End',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        FlatButton(
                          clipBehavior: Clip.antiAlias,
                          splashColor: AppColors.darkSkyBlue,
                          highlightColor: Colors.transparent,
                          color: AppColors.lightPeriwinkle,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, color: AppColors.cadetBlue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: Text(
                              _allDay == true
                                  ? DateFormat('E, MMM d, y').format(_endDate)
                                  : DateFormat('E, MMM d, y HH:mm')
                                      .format(_endDate),
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_allDay) {
                              var pickedDate = await _selectDate(
                                  context, _endDate, DateTime.now());
                              if (pickedDate != null) {
                                setState(() {
                                  _startDate = pickedDate.add(Duration(
                                      hours: _currentStartTime.hour,
                                      minutes: _currentStartTime.minute));
                                  _endDate = pickedDate.add(Duration(
                                      hours: _currentEndTime.hour,
                                      minutes: _currentEndTime.minute));
                                });
                              }
                            } else {
                              var pickedDate = await _selectDate(
                                  context, _endDate, _startDate);
                              if (pickedDate == null) return;
                              final pickedTime =
                                  await _selectTime(context, _currentEndTime);
                              if (pickedTime != null) {
                                if (pickedDate.isAfter(_startDate) ||
                                    pickedTime.hour > _currentStartTime.hour ||
                                    (pickedTime.hour ==
                                            _currentStartTime.hour &&
                                        pickedTime.minute >
                                            _currentStartTime.minute)) {
                                  DateTime newEndDateTime = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                      pickedTime.hour,
                                      pickedTime.minute);
                                  setState(() {
                                    _endDate = newEndDateTime;
                                    _currentEndTime = pickedTime;
                                  });
                                } else {
                                  print('-------------- evo me --------------');
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'End date should be later than start date...'),
                                  ));
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(_useNotifications == true
                        ? Icons.notifications
                        : Icons.notifications_off),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Notifications',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch(
                        value: _useNotifications,
                        activeColor: AppColors.cadetBlue,
                        activeTrackColor: AppColors.tealBlue,
                        inactiveThumbColor: AppColors.lightPeriwinkle,
                        inactiveTrackColor: AppColors.cadetBlue,
                        onChanged: (bool newValue) {
                          setState(() {
                            _useNotifications = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _useNotifications == true
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            notificationListEmpty()
                                ? SizedBox.shrink()
                                : Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        /*children: _allDay
                                            ? allDayTaskReminders
                                                .map((reminder) =>
                                                    makeNotificationCard(
                                                        reminder, context))
                                                .toList()
                                            : timeSensitiveTaskReminders
                                                .map((reminder) =>
                                                    makeNotificationCard(
                                                        reminder, context))
                                                .toList(),*/
                                        children: _listOfReminders
                                            .map((reminder) =>
                                                makeNotificationCard(
                                                    reminder, context))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                            /*FlatButton(
                              //clipBehavior: Clip.antiAlias,
                              shape: CircleBorder(),
                              //padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 20,
                                child: Icon(Icons.add,
                                    size: 32.0, color: AppColors.tealBlue),
                              ),
                              onPressed: () => print('add notifications'),
                            ),*/
                            IconButton(
                              alignment: Alignment.center,
                              iconSize: 32.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              icon: Icon(
                                Icons.add,
                              ),
                              color: AppColors. /*tealBlue*/ cadetBlue,
                              disabledColor: Colors.grey[400],
                              onPressed: isAddNotificationButtonEnabled()
                                  ? () async {
                                      final returnedReminder =
                                          await Navigator.of(context)
                                              .pushNamed<Reminder>(
                                        '/reminder_screen',
                                        arguments: {
                                          'reminder': null,
                                          'allDayTaskReminder': _allDay,
                                        },
                                      );
                                      if (returnedReminder != null) {
                                        if (!_listOfReminders.contains(
                                                returnedReminder) &&
                                            _listOfReminders.indexWhere(
                                                    (element) =>
                                                        element.toMinutes ==
                                                        returnedReminder
                                                            .toMinutes) ==
                                                -1) {
                                          setState(() {
                                            _listOfReminders
                                              ..add(returnedReminder)
                                              ..sort();
                                          });
                                        }
                                      }
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Divider(),
                // TODO: Repeating Tasks - coming in next version of app
                /*Row(
                  children: <Widget>[
                    Icon(
                      Icons.repeat,
                      */ /*color: !_useNotifications
                            ? Colors.grey[600]
                            : Colors.black*/ /*
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        _repeatingTask ? 'Repeat' : 'Do not repeat',
                        style: TextStyle(
                          fontSize: 20.0,
                          */ /*color: !_useNotifications
                                ? Colors.grey[600]
                                : Colors.black*/ /*
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch(
                        value: _repeatingTask,
                        activeColor: AppColors.cadetBlue,
                        activeTrackColor: AppColors.tealBlue,
                        inactiveThumbColor: AppColors.lightPeriwinkle,
                        inactiveTrackColor: AppColors.cadetBlue,
                        onChanged: (bool newValue) {
                          setState(() {
                            _repeatingTask = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _repeatingTask
                    ? FlatButton(
                        clipBehavior: Clip.antiAlias,
                        splashColor: AppColors.darkSkyBlue,
                        highlightColor: Colors.transparent,
                        color: AppColors.lightPeriwinkle,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0, color: AppColors.cadetBlue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          child: Text(
                            'Daily',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed('/repeat_screen');
                        },
                      )
                    : SizedBox.shrink(),
                Divider(),*/
                Row(
                  children: <Widget>[
                    Icon(Icons.note),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Notes',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch(
                        value: _hasNote,
                        activeColor: AppColors.cadetBlue,
                        activeTrackColor: AppColors.tealBlue,
                        inactiveThumbColor: AppColors.lightPeriwinkle,
                        inactiveTrackColor: AppColors.cadetBlue,
                        onChanged: (bool newValue) {
                          setState(() {
                            if (!newValue) _notesText = '';
                            _hasNote = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _hasNote
                    ? TextFormField(
                        maxLines: null,
                        maxLength: 160,
                        decoration: InputDecoration(
                          hintText: 'Notes...',
                          hintStyle: TextStyle(fontSize: 18.0),
                        ),
                        style: TextStyle(fontSize: 18.0),
                        validator: (String value) => value.isEmpty
                            ? 'If notes switch is on notes content can\'t be empty'
                            : null,
                        onSaved: (String value) {
                          setState(() {
                            _notesText = value;
                          });
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeNotificationCard(Reminder reminder, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPeriwinkle,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: AppColors.cadetBlue),
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.center,
      height: 40.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                print('samo da javim da radi');
                // TODO: prosledi reminder, radi nesto sa njim i vidi da li nesto vraca!!!
                final returnedReminder = await Navigator.of(context)
                    .pushNamed<Reminder>('/reminder_screen', arguments: {
                  'reminder': reminder,
                  'allDayTaskReminder': _allDay,
                });
                // TODO: prvo proveri da li je drugaciji od onog preko kojeg je otvoren, ako jeste izbrisi taj i dodaj novi, ako nije, ne radi nista
                if (returnedReminder != null) {
                  if (returnedReminder != reminder &&
                      returnedReminder.toMinutes != reminder.toMinutes) {
                    if (!_listOfReminders.contains(returnedReminder) &&
                        _listOfReminders.indexWhere((element) =>
                                element.toMinutes ==
                                returnedReminder.toMinutes) ==
                            -1) {
                      setState(() {
                        _listOfReminders.remove(reminder);
                        _listOfReminders
                          ..add(returnedReminder)
                          ..sort();
                      });
                    }
                    // onaj od kojeg se krenulo treba izbrisati
                  }
                } else {
                  print('vration je null');
                }
              },
              child: Text(
                reminder.toString(),
                style: TextStyles.mediumBodyTextStyle,
                //style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.remove, /*size: 26.0,*/ color: Colors.red),
            onPressed:
                /*_allDay
                ? () => setState(() {
                      allDayTaskReminders.remove(reminder);
                    })
                : () => setState(() {
                      timeSensitiveTaskReminders.remove(reminder);
                    }),*/
                () => setState(() {
              _listOfReminders.remove(reminder);
            }),
          ),
        ],
      ),
    );
  }

  bool isAddNotificationButtonEnabled() {
    /*if (_allDay) {
      if (allDayTaskReminders.length >= 0 && allDayTaskReminders.length < 3) {
        return true;
      }
      return false;
    } else {
      if (timeSensitiveTaskReminders.length >= 0 &&
          timeSensitiveTaskReminders.length < 3) {
        return true;
      }
      return false;
    }*/
    if (_listOfReminders.length >= 0 && _listOfReminders.length < 3) {
      return true;
    }
    return false;
  }

  /*void resetNotificationLists() {
    allDayTaskReminders
      ..clear()
      ..add(day_before_17h);
    timeSensitiveTaskReminders
      ..clear()
      ..add(tenMinutesBefore);
  }*/

  bool notificationListEmpty() {
    /*return allDayTaskReminders.length == 0 ||
        timeSensitiveTaskReminders.length == 0;*/
    return _listOfReminders.length == 0;
  }
}
