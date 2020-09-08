import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/services/notification_service.dart';

part 'daos.g.dart';

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
      (update(tasks)..where((t) => t.id.equals(task.id))).write(
        TasksCompanion(completed: Value(!task.completed)),
        dontExecute: task.completed,
      );

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
    final ProviderContainer container = ProviderContainer();
    final NotificationService notificationService =
        container.read(notificationServiceProvider);
    list.forEach((n) {
      notificationService.cancelNotification(n.id);
      deleteNotification(n);
    });
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
