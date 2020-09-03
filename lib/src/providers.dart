import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/data/database/daos.dart';
import 'package:task_manager_app/src/data/database/database.dart';

// Date providers
final currentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final selectedDateProvider =
StateProvider<DateTime>((ref) => ref.read(currentDateProvider).state);



final databaseProvider = Provider<AppDatabase>((ref) {
  var database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

final tasksDaoProvider = Provider<TasksDao>((ref) {
  final AppDatabase database = ref.read(databaseProvider);
  return database.tasksDao;
});

final notificationsDaoProvider = Provider<NotificationsDao>((ref) {
  final AppDatabase database = ref.read(databaseProvider);
  return database.notificationsDao;
});
