enum TimeInterval {
  min,
  hour,
  day,
  week,
}

// ignore: missing_return
String timeIntervalInBeforeFormat(TimeInterval value) {
  switch (value) {
    case TimeInterval.min:
      return 'min before';
    case TimeInterval.hour:
      return 'hour before';
    case TimeInterval.day:
      return 'day before';
    case TimeInterval.week:
      return 'week before';
  }
}
