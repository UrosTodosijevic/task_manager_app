import 'package:flutter/material.dart';
import 'package:task_manager_app/src/screens/repeat_screen.dart';
import 'package:task_manager_app/src/screens/screens.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class EditTaskScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cadetBlue,
      automaticallyImplyLeading: false,
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                highlightColor: Colors.transparent,
                textColor: AppColors.charcoal,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Text('CANCEL', style: TextStyle(fontSize: 22.0))),
                onPressed: () {
                  //Navigator.of(context).pushReplacementNamed('/home_screen');
                  print('pop()');
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                highlightColor: Colors.transparent,
                textColor: AppColors.charcoal,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Text('SAVE', style: TextStyle(fontSize: 22.0))),
                onPressed: () async {
                  final bool editingTaskSuccess = await editTaskScreenBodyStateKey
                      .currentState
                      .tryToEditTask();
                  if (editingTaskSuccess) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
