import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/src/data/database/daos.dart';

import 'package:task_manager_app/src/data/database/database.dart';

class TempHomeScreen extends StatefulWidget {
  @override
  _TempHomeScreenState createState() => _TempHomeScreenState();
}

class _TempHomeScreenState extends State<TempHomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TasksDao tasksDao = Provider.of<TasksDao>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nista'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Tasks List',
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: tasksDao.watchAllTasks,
              builder: (_, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.hasData) {
                  var tasks = snapshot.data /*??List()*/;
                  if (tasks.isNotEmpty) {
                    //TODO: ScrollBehavior
                    return ListView.separated(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final Task task = tasks[index];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(task.id.toString()),
                            SizedBox(width: 30.0),
                            Text(task.title),
                            SizedBox(width: 30.0),
                            Text(task.endDate.toString()),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    );
                  } else {
                    return Center(
                      child: Text('No Tasks For The Chosen Parameters'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*final AppDatabase database =
              Provider.of<AppDatabase>(context, listen: false);
          print(await database.deleteAllTasks());*/
        },
        tooltip: 'Delete all entries',
        child: Icon(Icons.remove),
      ),
    );
  }
}
