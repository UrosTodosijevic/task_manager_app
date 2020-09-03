import 'package:flutter/material.dart';

class SelectedDateProvider with ChangeNotifier {
  DateTime _selectedDate;

  SelectedDateProvider() {
    this._selectedDate = DateTime.now();
  }

  DateTime get date => _selectedDate;

  set date(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }
}
