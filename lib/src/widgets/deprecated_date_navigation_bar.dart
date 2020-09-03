import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task_manager_app/main.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/src/core/utils/date_utils.dart';
import 'package:task_manager_app/src/providers/selected_date_provider.dart';
import 'package:task_manager_app/src/screens/todo_list_screen.dart';
import 'package:task_manager_app/src/styles/base.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

class DateNavigationBar extends StatefulWidget {
  DateNavigationBar({Key key}) : super(key: key);

  @override
  _DateNavigationBarState createState() => _DateNavigationBarState();
}

// TODO:
/*
actualDate provider
current month u sklopu widgeta
strelicama menjati taj datum/mesec
 */

class _DateNavigationBarState extends State<DateNavigationBar> {
  DateTime currentDate = DateTime.now();

  //DateTime selectedDate;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    //selectedDate = /*DateTime(2020, 5, 25)*/ currentDate;

    _scrollController = ScrollController();
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
    // TODO: kasnije izbrisati showList
    bool showList = true;

    final selectedDateProvider = Provider.of<SelectedDateProvider>(context);

    List<DateTime> daysInMonth = allDaysInMonth(selectedDateProvider.date);

    var dateCardWidth = MediaQuery.of(context).size.width / 7;
    if (_scrollController.hasClients) {
      //_scrollController.jumpTo(calculateOffset(dateCardWidth));
      _scrollController.animateTo(
          calculateOffset(selectedDateProvider.date, dateCardWidth),
          duration: Duration(seconds: 1),
          curve: Curves.ease);
    }
    /*_scrollController.animateTo(selectedDate.day * d,
        duration: Duration(seconds: 1), curve: Curves.ease);*/

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text('MY EVENTS', style: TextStyles.appBarBigTextStyle,),
            Text(
              DateFormat.yMMMMEEEEd().format(selectedDateProvider.date),
              style: /*TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)*/TextStyles.appBarSmallTextStyle,
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoListScreen())),
        ),
        elevation: BaseStyles.appBarElevation,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print('SOON...'),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              selectedDateProvider.date = currentDate;
            },
          ),
        ],
        backgroundColor: /*BaseStyles.appBarBackgroundColor*/AppColors.cadetBlue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            alignment: Alignment.center,
            color: Colors.white70,
            child: Material(
              elevation: 4.0,
              //color: AppColors.cadetBlue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => selectedDateProvider.date =
                                _previousMonth(selectedDateProvider.date)),
                        Text(
                          DateFormat('MMMM, y')
                              .format(selectedDateProvider.date)
                              .toUpperCase(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            selectedDateProvider.date =
                                _nextMonth(selectedDateProvider.date);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: daysInMonth.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime date = daysInMonth[index];
                        return GestureDetector(
                          child: (selectedDateProvider.date.day == date.day)
                              ? SelectableDateCard(date: date, selected: true)
                              : SelectableDateCard(date: date),
                          onTap: () {
                            if (selectedDateProvider.date.day != date.day) {
                              selectedDateProvider.date = date;
                            }
                          },
                        );
                        /*if (selectedDate.day == date.day) {
                        return SelectableDateCard(
                            date: daysInMonth[index], selected: true);
                      }
                      return SelectableDateCard(date: date);*/
                      },
                    )
                    //listOfSelectableDateCards
                    ,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: showList
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'You currently have no Task or Reminders set',
                            style: TextStyle(fontSize: 20.0, /*color: AppColors.raisinBlack*/),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            'Click on Plus button to create new Reminder',
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Task',
        backgroundColor: AppColors.cadetBlue,
        child: Icon(Icons.add, size: 30.0, color: AppColors.charcoal,),
        onPressed: () => print('SOON... Adding New Task...'),
      ),

    );
  }

  DateTime _previousMonth(DateTime selectedDate) {
    final DateTime lastDayOfPreviousMonth = getLastDayOfPreviousMonth(selectedDate);

    return lastDayOfPreviousMonth;
  }

  DateTime _nextMonth(DateTime selectedDate) {
    final DateTime firstDayOfNextMonth = getFirstDayOfNextMonth(selectedDate);

    return firstDayOfNextMonth;
  }
}

class SelectableDateCard extends StatefulWidget {
  DateTime date;
  bool selected;

  SelectableDateCard({
    this.date,
    this.selected = false,
  });

  @override
  _SelectableDateCardState createState() => _SelectableDateCardState();
}

class _SelectableDateCardState extends State<SelectableDateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 7,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width / 7 * 0.1,
          bottom: MediaQuery.of(context).size.width / 7 * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat.E().format(widget.date).substring(0, 1),
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 7 * 0.9,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.selected ? Colors.red[700]/*AppColors.charcoal*/ : AppColors.gainsboro,
                ),
                child: Center(
                  child: Text(
                    widget.date.day.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: widget.selected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
