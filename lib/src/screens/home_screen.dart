import 'package:flutter/material.dart';
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/src/widgets/home_screen/app_bar/home_screen_app_bar.dart';
import 'package:task_manager_app/src/widgets/home_screen/body/home_screen_body.dart';
import 'package:task_manager_app/src/widgets/home_screen/floating_action_button/home_screen_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    // Todo: dodaj trenutak kad je notifikacija kliknuta, ili to nije protrebno jer bih koristio snooze od now ?!
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.of(context)
          .pushNamed('/task_notification_screen', arguments: payload);
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeScreenAppBar(),
      body: HomeScreenBody(),
      floatingActionButton: HomeScreenFloatingActionButton(),
    );
  }
}
