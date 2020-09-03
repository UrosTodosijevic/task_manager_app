// This is not the class with  methods because:

/*Creating classes with the sole purpose of providing utility or otherwise
 methods is discouraged. Dart allows functions to exist outside of
classes for this very reason.*/

// Effective Dart
// https://dart.dev/guides/language/effective-dart/design#avoid-defining-a-class-that-contains-only--members

int _getNumberOfDaysInMonth(DateTime date) {
  if (date != null) {
    DateTime firstDayOfNextMonth;
    if (date.month < 12) {
      firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
    } else {
      firstDayOfNextMonth = DateTime(date.year + 1, 1, 1);
    }
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }
  return null;
}

DateTime lastDayOfGivenMonth(DateTime date) {
  if (date != null) {
    int lastDay = _getNumberOfDaysInMonth(date);
    return DateTime(date.year, date.month, lastDay);
  }
  return null;
}

DateTime firstDayOfGivenMonth(DateTime date) {
  if (date != null) {
    return DateTime(date.year, date.month, 1);
  }
  return null;
}

List<DateTime> allDaysInMonth(DateTime date) {
  if (date != null) {
    int numberOfDaysInMonth = _getNumberOfDaysInMonth(date);
    List<DateTime> listOfDaysInMonth = [];
    for (int i = 1; i <= numberOfDaysInMonth; i++) {
      listOfDaysInMonth.add(DateTime(date.year, date.month, i));
    }
    return listOfDaysInMonth;
  }
  return null;
}

// 1. add WithYear on method name ?!
// 2. method was called getPreviousMonth before this name was given
DateTime getLastDayOfPreviousMonth(DateTime date) {
  if (date != null) {
    if (date.month == DateTime.january) {
      return DateTime(date.year - 1, DateTime.december, 31);
    } else {
      int numberOfDaysInPreviousMonth =
          _getNumberOfDaysInMonth(DateTime(date.year, date.month - 1));
      return DateTime(date.year, date.month - 1, numberOfDaysInPreviousMonth);
    }
  }
  return null;
}

// 1. add WithYear on method name ?!
// 2. method was called getNextMonth before this name was given
DateTime getFirstDayOfNextMonth(DateTime date) {
  if (date != null) {
    if (date.month == DateTime.december) {
      return DateTime(date.year + 1, 1, 1);
    } else {
      return DateTime(date.year, date.month + 1, 1);
    }
  }
  return null;
}
