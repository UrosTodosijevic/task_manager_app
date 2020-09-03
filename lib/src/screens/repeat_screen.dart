import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:task_manager_app/src/models/repeat_option.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

class RepeatScreen extends StatefulWidget {
  @override
  _RepeatScreenState createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen> {
  RepeatOption _selectedRepeatOption = RepeatOption.never;

  RepeatDurationWithName _selectedRepeatDuration = repeatForever;

  //String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    var values = RepeatOption.values;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cadetBlue,
        automaticallyImplyLeading: true,
        title: Text('Repeat', style: TextStyles.appBarBigTextStyle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => print('Save Repeat and go back'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: AppColors.gainsboro,
              child: Column(
                children: <Widget>[
                  _makeRepeatOptionTile('Never', RepeatOption.never),
                  _repeatOptionListDivider(),
                  _makeRepeatOptionTile('Daily', RepeatOption.daily),
                  _repeatOptionListDivider(),
                  _makeRepeatOptionTile('Weekly', RepeatOption.weekly),
                  _repeatOptionListDivider(),
                  _makeRepeatOptionTile('Monthly', RepeatOption.monthly),
                  _repeatOptionListDivider(),
                  _makeRepeatOptionTile('Yearly', RepeatOption.yearly),
                  _repeatOptionListDivider(),
                  _makeRepeatOptionTile('Customize', RepeatOption.customize),
                  _selectedRepeatOption == RepeatOption.customize
                      ? _showCustomizationContainer()
                      : SizedBox(height: 6.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 170.0,
              color: AppColors.gainsboro,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedRepeatDuration,
                        disabledHint: Row(
                          children: [
                            Text(_selectedRepeatDuration.name),
                            SizedBox(width: 28.0),
                          ],
                        ),
                        items: _selectedRepeatOption == RepeatOption.never
                            ? null
                            : listOfRepeatDurations.map((element) {
                                return DropdownMenuItem(
                                  child: Text(element.name),
                                  value: element,
                                );
                              }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRepeatDuration = value;
                          });
                        },
                      ),
                      SizedBox(width: 50.0),
                      _repeatDurationExtra(_selectedRepeatDuration, context),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  ListTile _makeRepeatOptionTile(String label, RepeatOption repeatOption) {
    return ListTile(
      title: Text(
        label,
        style: TextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      leading: Radio(
        activeColor: AppColors.cadetBlue,
        value: repeatOption,
        groupValue: _selectedRepeatOption,
        onChanged: (RepeatOption value) {
          setState(() {
            _selectedRepeatOption = value;
          });
        },
      ),
    );
  }

  Divider _repeatOptionListDivider() {
    return Divider(height: 4.0, indent: 10.0, endIndent: 10.0);
  }

  Widget _showCustomizationContainer() {
    return Column(
      children: [
        _repeatOptionListDivider(),
        Container(
          height: 200.0,
          color: Colors.red,
          /*child: Column(
            children: [
              DropdownButton(
                value: listOfRepeatOptions[0].keys.toList()[0],
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  print(newValue);
                },
                items:
                    */ /*<String>['One', 'Two', 'Free', 'Four']
                   .map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value),
                     );
                   })
                   .toList(),*/ /*
                    listOfRepeatOptions
                        .sublist(1, 5)
                        .map((Map<String, RepeatOption> option) {
                  return DropdownMenuItem(
                    value: option.values.toList()[0],
                    child: Text(option.keys.toList()[0]),
                  );
                }).toList(),
              ),
            ],
          ),*/
        ),
      ],
    );
  }
}

Widget _repeatDurationExtra(
    RepeatDurationWithName duration, BuildContext context) {
  if (duration.repeatDuration == RepeatDuration.forever) {
    return SizedBox.shrink();
  } else if (duration.repeatDuration == RepeatDuration.until) {
    return FlatButton(
      clipBehavior: Clip.antiAlias,
      splashColor: AppColors.darkSkyBlue,
      highlightColor: Colors.transparent,
      color: AppColors.lightPeriwinkle,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: AppColors.cadetBlue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Text(
          DateFormat('E, MMM d, y').format(DateTime.now()),
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      //),
      onPressed: () async {
        await showDateRangePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365 * 5)));
      },
    );
  } else {
    return Container(
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 2,
      ),
    );
  }
}
