import 'package:flutter/material.dart';
import 'package:task_manager_app/main.dart';

class DispatchWidget extends StatefulWidget {
  @override
  _DispatchWidgetState createState() => _DispatchWidgetState();
}

class _DispatchWidgetState extends State<DispatchWidget> {
  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.of(context).pushNamed('/task_notification_screen', arguments: payload);
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pushNamed('/home_screen');
  }
}
