import 'package:intl/intl.dart';

class Formatting {
  /*static final s = DateFormat.*/
  static final DateFormat srpski = DateFormat.yMMMMd('sr_RS');
  static final DateFormat americki = DateFormat.yMMMMd('en_US');

  Formatting._();

  static Formatting instance = Formatting._();

  String monthCommaYear() {
    return DateFormat('MMMM, y').format(null);
  }
}

NumberFormat timeNumberFormat = NumberFormat()..minimumIntegerDigits = 2;