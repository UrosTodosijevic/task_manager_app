import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'date_picker_widgets.dart';

class ScrollableDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.gainsboro,
        boxShadow: [
          BoxShadow(
            color: AppColors.raisinBlack.withOpacity(0.5),
            offset: Offset(1.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CustomMonthPicker(),
          ),
          Expanded(
            flex: 3,
            child: CustomDayPicker(),
          ),
        ],
      ),
    );
  }
}
