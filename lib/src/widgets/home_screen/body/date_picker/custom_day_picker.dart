import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/core/utils/date_utils.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/date_picker/selectable_date_card.dart';

class CustomDayPicker extends StatefulWidget {
  @override
  _CustomDayPickerState createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // TODO: Mozda ovde dodati prvu animaciju do datuma, jer se nekad desava da je ne napravi do pritiska refresh dugmeta
    /*print(_scrollController.position);
    print(_scrollController.offset);
    print(_scrollController.hasClients);
    print(_scrollController.hasListeners);
    print(_scrollController.initialScrollOffset);
    print(_scrollController.positions);*/
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double calculateOffset(DateTime selectedDate, double dateCardWidth) {
    DateTime lastDay = lastDayOfGivenMonth(selectedDate);

    if (selectedDate.day < 3) {
      return 0.0;
    } else if (selectedDate.day + 5 > lastDay.day) {
      return selectedDate.day * dateCardWidth;
    } else {
      return (selectedDate.day - 3) * dateCardWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final DateTime selectedDate = watch(selectedDateProvider).state;
        List<DateTime> daysInMonth = allDaysInMonth(selectedDate);

        double dateCardWidth = BaseStyles.selectableDateCardWidth(context);
        //
        //if (_scrollController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // Todo: samo za proveru, izbrisati kada i selectableDateCard predje na riverpod
          print(selectedDate);
          _scrollController.animateTo(
              calculateOffset(selectedDate, dateCardWidth),
              duration: Duration(seconds: 1),
              curve: Curves.ease);
        });
        //}

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: daysInMonth.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime date = daysInMonth[index];
            return SelectableDateCard(date);
          },
        );
      },
    );
  }
}
