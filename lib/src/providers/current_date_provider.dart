import 'package:flutter/material.dart';

class CurrentDateProvider with ChangeNotifier {
  DateTime _currentDate;

  CurrentDateProvider() {
    this._currentDate = DateTime.now();
  }

  DateTime get date => _currentDate;

  set date(DateTime newDate) {
    _currentDate = newDate;
    notifyListeners();
  }
}
