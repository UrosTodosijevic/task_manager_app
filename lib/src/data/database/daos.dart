import 'package:moor/moor.dart';
import 'package:task_manager_app/src/data/database/database.dart';

part 'daos.g.dart';

/*
@UseDao(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  // loads all tasks
  Future<List<Task>> get getAllTasks => (select(tasks)
        ..orderBy([
          (task) => OrderingTerm(expression: task.dueDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .get();

  // watches all tasks. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Task>> get watchAllTasks => (select(tasks)
        ..orderBy([
          (task) => OrderingTerm(expression: task.dueDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .watch();

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<bool> updateTask(TasksCompanion task) => update(tasks).replace(task);

  Future<int> deleteTask(TasksCompanion task) => delete(tasks).delete(task);

  Future<int> deleteAllTasks() => delete(tasks).go();

  Stream<List<Task>> get watchCompletedTasks => (select(tasks)
        ..where((t) => t.completed.equals(true))
        ..orderBy([
          (task) => OrderingTerm(expression: task.dueDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .watch();

  Stream<List<Task>> get watchCompletedTasksInCurrentDay {
    final currentDate = DateTime.now();
    return (select(tasks)
          ..where((t) =>
              t.completed.equals(true) &
              t.dueDate.year.equals(currentDate.year) &
              t.dueDate.month.equals(currentDate.month) &
              t.dueDate.day.equals(currentDate.day))
          ..orderBy([
            (task) => OrderingTerm(expression: task.dueDate),
            (task) => OrderingTerm(expression: task.title),
          ]))
        .watch();
  }

  Stream<List<Task>> watchOverdueTasks({int inPastDay = 5}) {
    // TODO: finish this method
    DateTime fromDate = DateTime.now().add(Duration(days: inPastDay));

    return (select(tasks)
          ..where((t) =>
              t.completed.equals(false) &
              t.dueDate.isSmallerThanValue(DateTime.now()))
          ..orderBy([
            (task) => OrderingTerm(expression: task.dueDate),
            (task) => OrderingTerm(expression: task.title),
          ]))
        .watch();
  }
}
*/
@UseDao(tables: [Categories, Tasks])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Category>> get getAllCategories => select(categories).get();

  Stream<List<Category>> get watchAllCategories => select(categories).watch();

  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);

// TODO: update name of category - u principu, to radi f-ja iznad

// TODO: add/edit delete
/*Future deleteCategory(Category category) {
    // first, move the affected tasks entries back to the default category
    return transaction(() async {
      await (update(tasks)..where((task) => task.category.equals(category.id)))
          .write(TasksCompanion(
        category: Value(null),
      ));
      // then, delete the category
      await delete(categories).delete(category);
    });
  }*/

/*Future deleteAllCategories() async {
    var list = await getAllCategories;
    list.forEach((element) => deleteCategory(element));
  }*/
}

@UseDao(tables: [Helpers, Tasks])
class HelpersDao extends DatabaseAccessor<AppDatabase> with _$HelpersDaoMixin {
  HelpersDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Helper>> get getAllHelpers => select(helpers).get();

  Stream<List<Helper>> get watchAllHelpers => select(helpers).watch();

  Future<int> insertHelper(HelpersCompanion helper) =>
      into(helpers).insert(helper);

// TODO: update helpers email
}

@UseDao(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Todo>> get getAllTodos => select(todos).get();

  Stream<List<Todo>> get watchAllTodos => select(todos).watch();

  Future<int> insertTodo(TodosCompanion todo) => into(todos).insert(todo);

  //Future<bool> updateTodo(Todo todo) => update(todos).replace(todo);

  Future updateTodo(Todo todo) =>
      (update(todos)..where((t) => t.id.equals(todo.id)))
          .write(TodosCompanion(completed: Value(!todo.completed)));

  Future<int> deleteTodo(Todo todo) => delete(todos).delete(todo);
}

@UseDao(tables: [Tasks, Notifications])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  // loads all tasks
  Future<List<Task>> get getAllTasks => (select(tasks)
        ..orderBy([
          (task) => OrderingTerm(expression: task.startDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .get();

  // watches all tasks. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Task>> get watchAllTasks => (select(tasks)
        ..orderBy([
          (task) => OrderingTerm(expression: task.startDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .watch();

  Stream<List<Task>> watchAllTasksInDay(DateTime date) => (select(tasks)
        ..where((t) =>
            t.startDate.year.equals(date.year) &
            t.startDate.month.equals(date.month) &
            t.startDate.day.equals(date.day))
        ..orderBy([
          (task) => OrderingTerm(expression: task.startDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .watch();

  // TODO: Verovatno bih trebao da implementiram .catchError() da pokrijem slucaj kada dodje do greske pri pravljenju taska, npr. poslati poruku na ErrorScreen
  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<bool> updateTask(TasksCompanion task) => update(tasks).replace(task);

  Future<int> updateCompleted(Task task) =>
      (update(tasks)..where((t) => t.id.equals(task.id)))
          .write(TasksCompanion(completed: Value(!task.completed)));

  Future<int> deleteTask(Task task) {
    return transaction(() async {
      await super
          .attachedDatabase
          .notificationsDao
          .deleteTaskNotifications(task);

      return delete(tasks).delete(task);
    });

    //return delete(tasks).delete(task);
  }

  Future<int> deleteTaskById(int taskId) {
    return transaction(() async {
      await super
          .attachedDatabase
          .notificationsDao
          .deleteTaskNotificationsByTaskId(taskId);

      return (delete(tasks)..where((t) => t.id.equals(taskId))).go();
    });
  }

  Future<Task> getTask(int id) {
    return (select(tasks)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<Task> getTaskUsingNotificationId(int notificationId) async {
    final notification = await (select(notifications)
          ..where((n) => n.id.equals(notificationId)))
        .getSingle();
    return (select(tasks)..where((t) => t.id.equals(notification.taskId)))
        .getSingle();
  }

  Future<int> deleteAllTasks() => delete(tasks).go();

  Stream<List<Task>> get watchCompletedTasks => (select(tasks)
        ..where((t) => t.completed.equals(true))
        ..orderBy([
          (task) => OrderingTerm(expression: task.startDate),
          (task) => OrderingTerm(expression: task.title),
        ]))
      .watch();

  Stream<List<Task>> get watchCompletedTasksInCurrentDay {
    final currentDate = DateTime.now();
    return (select(tasks)
          ..where((t) =>
              t.completed.equals(true) &
              t.startDate.year.equals(currentDate.year) &
              t.startDate.month.equals(currentDate.month) &
              t.startDate.day.equals(currentDate.day))
          ..orderBy([
            (task) => OrderingTerm(expression: task.startDate),
            (task) => OrderingTerm(expression: task.title),
          ]))
        .watch();
  }

  Stream<List<Task>> watchOverdueTasks({int inPastDay = 5}) {
    // TODO: finish this method
    DateTime fromDate = DateTime.now().add(Duration(days: inPastDay));

    return (select(tasks)
          ..where((t) =>
              t.completed.equals(false) &
              t.startDate.isSmallerThanValue(DateTime.now()))
          ..orderBy([
            (task) => OrderingTerm(expression: task.startDate),
            (task) => OrderingTerm(expression: task.title),
          ]))
        .watch();
  }
}

@UseDao(tables: [Notifications])
class NotificationsDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationsDaoMixin {
  NotificationsDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<Notification> getNotification(int id) {
    return (select(notifications)..where((n) => n.id.equals(id))).getSingle();
  }

  Future<List<Notification>> get getAllNotifications =>
      select(notifications).get();

  Stream<List<Notification>> get watchAllNotifications =>
      select(notifications).watch();

  Future<int> insertNotification(NotificationsCompanion notification) =>
      into(notifications).insert(notification);

  /*Future updateNotification(Notification notification) =>
      (update(notifications)
        ..where((n) => n.id.equals(notification.id)))
          .write(
          NotificationsCompanion(dateAndTime: Value(notification.dateAndTime));
      );*/

  Future<int> deleteNotification(Notification notification) =>
      delete(notifications).delete(notification);

  Future<int> deleteNotificationById(int notificationId) {
    return (delete(notifications)..where((n) => n.id.equals(notificationId)))
        .go();
  }

  Future<List<Notification>> getTaskNotifications(Task task) {
    return (select(notifications)
          ..where((notification) => notification.taskId.equals(task.id)))
        .get();
  }

  Future<List<Notification>> getTaskNotificationsByTaskId(int taskId) {
    return (select(notifications)
          ..where((notification) => notification.taskId.equals(taskId)))
        .get();
  }

  Future deleteTaskNotifications(Task task) async {
    final List<Notification> list = await getTaskNotifications(task);
    // TODO: ovo je verovatno podeljeno na dva dela jer sam mislio da cu ovde da iskljucujem notifikacije pre njihovog brisanja,
    // TODO: inace je brisanje moglo biti uradjeno u jednom koraku
    // TODO: mozda je bolje u UI kodu, pre brisanja pozvati funkciju koja vraca niz notifikacija, odatle ih iskljuciti a potom ih izbrisati iz baze jednom funkcijom
    list.forEach((n) => deleteNotification(n));
  }

  deleteTaskNotificationsByTaskId(int taskId) async {
    final List<Notification> list = await getTaskNotificationsByTaskId(taskId);
    list.forEach((n) => deleteNotification(n));
  }

  Stream<List<Notification>> watchTaskNotification(int taskId) {
    return (select(notifications)
          ..where((notification) => notification.taskId.equals(taskId)))
        .watch();
  }
}
