import 'package:flutter/material.dart';
import 'package:task_manager_app/src/screens/repeat_screen.dart';
import 'package:task_manager_app/src/styles/styles.dart';

class NewTaskScreenAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  // TODO: proveriti da li aplikacija radi kako treba sa ovim final
  /*final */GlobalKey formKey;

  NewTaskScreenAppBar(this.formKey);

  @override
  _NewTaskScreenAppBarState createState() => _NewTaskScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _NewTaskScreenAppBarState extends State<NewTaskScreenAppBar> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
  }

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
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _formKey.currentState
                      .reset(); // added this to clear input fields
                  //var notificationService = NotificationService.instance;
                  /*var notificationService =
                      context.read(notificationServiceProvider);*/
                  print('trebalo bi da je resetovao texteditingcontroller');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RepeatScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
