import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/data/database/daos.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/services/notification_service.dart';

// Date providers
final currentDateProvider = StateProvider<DateTime>((ref) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day, now.hour, now.minute);
});

final selectedDateProvider =
    StateProvider<DateTime>((ref) => ref.read(currentDateProvider).state);

// Database providers - potentially change to service
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

// Notification service providers
final notificationServiceProvider = Provider<NotificationService>((ref) {
  var notificationService = NotificationService();
  // Mozda nije potrebno
  ref.onDispose(() => notificationService.cancelAllNotifications());
  return notificationService;
});
