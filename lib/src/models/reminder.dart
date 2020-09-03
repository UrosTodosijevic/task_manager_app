import 'package:flutter/material.dart';
import 'package:task_manager_app/src/core/formatting.dart';

abstract class Reminder implements Comparable<Reminder> {
  const Reminder();

  int get toMinutes;

  @override
  int compareTo(Reminder other) {
    return this.toMinutes - other.toMinutes;
  }
}

/// Reminder for task that will happen at set time
class ReminderForTimeSensitiveTask extends Reminder {
  final int minutes;
  final int hours;
  final int days;
  final int weeks;

  const ReminderForTimeSensitiveTask({
    this.minutes = 0,
    this.hours = 0,
    this.days = 0,
    this.weeks = 0,
  }) : super();

  @override
  String toString() {
    if (minutes != 0) return '$minutes min before';
    if (hours != 0) return '$hours hour${hours != 1 ? 's' : ''} before';
    if (days != 0) return '$days day${days != 1 ? 's' : ''} before';
    if (weeks != 0) return '$weeks week${weeks != 1 ? 's' : ''} before';
    return 'On time';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderForTimeSensitiveTask &&
          runtimeType == other.runtimeType &&
          minutes == other.minutes &&
          hours == other.hours &&
          days == other.days &&
          weeks == other.weeks;

  @override
  int get hashCode =>
      minutes.hashCode ^ hours.hashCode ^ days.hashCode ^ weeks.hashCode;

  //minutes + hours * 60 + days * 24 * 60 + weeks * 7 * 24 * 60;

  int get toMinutes {
    return minutes + hours * 60 + days * 24 * 60 + weeks * 7 * 24 * 60;
  }

  DateTime notificationDateTime(DateTime taskDateTime) {
    return taskDateTime.subtract(Duration(
      minutes: minutes,
      hours: hours,
      days: days != 0 ? days : weeks * 7,
    ));
  }
}

const onTime = const ReminderForTimeSensitiveTask();
const tenMinutesBefore = const ReminderForTimeSensitiveTask(minutes: 10);
const thirtyMinutesBefore = const ReminderForTimeSensitiveTask(minutes: 30);
const oneHourBefore = const ReminderForTimeSensitiveTask(hours: 1);
const oneDayBefore = const ReminderForTimeSensitiveTask(days: 1);
const oneWeekBefore = const ReminderForTimeSensitiveTask(weeks: 1);

const List<ReminderForTimeSensitiveTask> defaultRemindersForTimeSensitiveTasks =
    [
  onTime,
  tenMinutesBefore,
  thirtyMinutesBefore,
  oneHourBefore,
  oneDayBefore,
  oneWeekBefore,
];

List<ReminderForTimeSensitiveTask> kopijaDefaultRemindersForTimeSensitiveTasks =
    [
  oneHourBefore,
  tenMinutesBefore,
  onTime,
  oneWeekBefore,
  oneDayBefore,
  thirtyMinutesBefore,
];

/// Reminders for tasks that last whole day
class ReminderForAllDayTasks extends Reminder {
  final days;
  final weeks;
  final TimeOfDay time;

  const ReminderForAllDayTasks({
    this.days = 0,
    this.weeks = 0,
    this.time = const TimeOfDay(hour: 0, minute: 0),
  }) : super();

  @override
  String toString() {
    if (days == 0 && weeks == 0)
      return 'Day of task at ${timeNumberFormat.format(time.hour)}:${timeNumberFormat.format(time.minute)}';
    if (days != 0)
      return '${days == 1 ? 'Day' : '$days days'} before task at ${timeNumberFormat.format(time.hour)}:${timeNumberFormat.format(time.minute)}';
    if (weeks != 0)
      return '$weeks week${weeks == 1 ? '' : 's'} before task at ${timeNumberFormat.format(time.hour)}:${timeNumberFormat.format(time.minute)}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderForAllDayTasks &&
          runtimeType == other.runtimeType &&
          days == other.days &&
          weeks == other.weeks &&
          time == other.time;

  @override
  int get hashCode => days.hashCode ^ weeks.hashCode ^ time.hashCode;

  DateTime notificationDateTime(DateTime taskDateTime) {
    DateTime newDate = taskDateTime.subtract(Duration(
      days: days != 0 ? days : weeks * 7,
    ));
    DateTime notificationDateTime = DateTime(
        newDate.year, newDate.month, newDate.day, time.hour, time.minute);
    return notificationDateTime;
  }

  @override
  int get toMinutes {
    return (days * 24 * 60 + weeks * 7 * 24 * 60) -
        (time.hour * 60 + time.minute);
  }
}

const day_of_00h = const ReminderForAllDayTasks();
const day_before_17h =
    const ReminderForAllDayTasks(days: 1, time: TimeOfDay(hour: 17, minute: 0));
const day_before_09h =
    const ReminderForAllDayTasks(days: 1, time: TimeOfDay(hour: 9, minute: 0));
const two_days_before_09h =
    const ReminderForAllDayTasks(days: 2, time: TimeOfDay(hour: 9, minute: 0));
const week_before_09h =
    const ReminderForAllDayTasks(weeks: 1, time: TimeOfDay(hour: 9, minute: 0));

const List<ReminderForAllDayTasks> defaultRemindersForAllDayTasks = [
  day_of_00h,
  day_before_17h,
  day_before_09h,
  two_days_before_09h,
  week_before_09h,
];

List<ReminderForAllDayTasks> kopijaDefaultRemindersForAllDayTasks = [
  week_before_09h,
  two_days_before_09h,
  day_before_17h,
  day_of_00h,
  day_before_09h,
];
