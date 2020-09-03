import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/src/data/database/daos.dart';
import 'package:task_manager_app/src/data/database/database.dart';

import 'package:moor/moor.dart' hide Column;
import 'package:task_manager_app/src/styles/colors.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    double paddingValue =
        (MediaQuery.of(context).size.width * 0.03).roundToDouble();
    double cardHeight =
        (MediaQuery.of(context).size.height / 11).roundToDouble();

    var todosDao = Provider.of<TodosDao>(context);

    // TODO: izbaciti kasnije, ovo je samo zbog isprobavanja baze
    var random = Random();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // TODO: izvuci sve stilove za tekst (u appBaru i ostatku aplikacije) na jedno mesto
        title: Column(
          children: <Widget>[
            Text('GROCERY LIST'),
            // TODO: dodaj broj koji me menja prema broju zadataka u listi
            Text(
              '15 Products',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        elevation: 10.0,
      ),
      body: StreamBuilder<List<Todo>>(
        stream: todosDao.watchAllTodos,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data != null) {
              var listOfTodos = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                itemCount: listOfTodos.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentTodo = listOfTodos[index];
                  return Card(
                    //color: AppColors.gainsboro,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Container(
                        height: cardHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: currentTodo.completed
                                  ? Icon(Icons.check_box, color: Colors.red)
                                  : Icon(Icons.check_box_outline_blank,
                                      color: Colors.grey),
                              iconSize: 28.0,
                              onPressed: () async {
                                // TODO: change to Todo instead of TodosCompanion
                                /*var todosCompanion = TodosCompanion(
                                  id: Value(currentTodo.id),
                                  name: Value(currentTodo.name),
                                  completed: Value(!currentTodo.completed),
                                );
                                await todosDao.updateTodo(todosCompanion);*/
                                //currentTodo.completed = !currentTodo.completed;
                                await todosDao.updateTodo(currentTodo);
                                //await todosDao.deleteTodo(currentTodo);
                              },
                            ),
                            SizedBox(width: 20.0),
                            GestureDetector(
                              onTap: () => print('Single Tap - do nothing'),
                              onDoubleTap: () => print(
                                  'Double Tap - should offer name change - maybe in popup dialog'),
                              child: currentTodo.completed
                                  ? Text(
                                      currentTodo.name,
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 20.0,
                                          color: Colors.grey),
                                    )
                                  : Text(currentTodo.name,
                                      style: TextStyle(fontSize: 20.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: Text('Snapshot data is null...'));
          }
        },

        /*builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            child: ListView.builder(
              itemCount: listOfTodos.length,
              itemBuilder: (BuildContext context, int index) {
                Todo currentTodo = groceryList[index];
                //return TodoListItem();
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Container(
                      height: cardHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: currentTodo.done
                                ? Icon(Icons.check_box, color: Colors.red)
                                : Icon(Icons.check_box_outline_blank,
                                    color: Colors.grey),
                            iconSize: 28.0,
                            onPressed: () {
                              print('current done state: ${currentTodo.done}');
                              currentTodo.changeDoneProperty();
                              print(
                                  'after changes done state: ${currentTodo.done}');
                            },
                          ),
                          SizedBox(width: 20.0),
                          currentTodo.done
                              ? Text(
                                  currentTodo.name,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 20.0,
                                      color: Colors.grey),
                                )
                              : Text(currentTodo.name,
                                  style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }*/
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Todo',
        child: Icon(Icons.add, size: 30.0),
        onPressed: () async {
          List<Todo> listBefore = await todosDao.getAllTodos;
          print('Number of Todos in list: ${listBefore.length}');
          print('Adding Todo in database');
          await todosDao.insertTodo(TodosCompanion(
            name: Value('Todo ${random.nextInt(100)}'),
          ));
          List<Todo> listAfter = await todosDao.getAllTodos;
          print('Number of Todos in list: ${listAfter.length}');
        },
      ),
    );
  }
}

/*
class TodoListItem extends StatefulWidget {
  Todo todo;

  TodoListItem(this.todo);

  @override
  _TodoListItemState createState() => _TodoListItemState();
}


class Todo {
  bool _done;
  String _name;

  Todo(String name, bool done) {
    this._name = name;
    this._done = done;
  }

  bool get done => _done;

  String get name => _name;

  void changeDoneProperty() {
    _done = !_done;
  }

  void changeNameProperty(String newName) {
    _name = newName;
  }
}

class _TodoListItemState extends State<TodoListItem> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: widget.todo.done
                ? Icon(Icons.check_box, color: Colors.red)
                : Icon(Icons.check_box_outline_blank, color: Colors.grey),
            iconSize: 28.0,
            onPressed: () {
              print('current done state: ${widget.todo.done}');
              setState(() {
                widget.todo.changeDoneProperty();
              });
              print('after changes done state: ${widget.todo.done}');
            },
          ),
          SizedBox(width: 20.0),
          widget.todo.done
              ? Text(
                  widget.todo.name,
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 20.0,
                      color: Colors.grey),
                )
              : Text(widget.todo.name, style: TextStyle(fontSize: 20.0)),
        ],
      ),
    );
  }
}
*/
