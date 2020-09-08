import 'dart:io';

import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:task_manager_app/src/data/database/daos.dart';

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  TextColumn get notes => text().nullable().withLength(max: 160)();

  BoolColumn get allDayTask => boolean().withDefault(const Constant(false))();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get dateAndTime => dateTime()();

  IntColumn get taskId => integer().customConstraint('REFERENCES tasks(id)')();
}

@UseMoor(
  tables: [Tasks, Notifications],
  daos: [TasksDao, NotificationsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          if (details.wasCreated) {
            await into(tasks).insert(TasksCompanion(
              title: Value('Prvi task'),
              completed: Value(true),
              startDate: Value(DateTime.now().add(Duration(hours: 1))),
              endDate: Value(DateTime.now().add(Duration(hours: 2))),
              notes: Value('Opis prvog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Drugi task'),
              completed: Value(false),
              startDate: Value(DateTime.now().add(Duration(hours: 1))),
              endDate: Value(DateTime.now().add(Duration(hours: 3))),
              notes: Value('Opis drugog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Treci task'),
              startDate: Value(DateTime.now().add(Duration(hours: 2))),
              endDate: Value(DateTime.now().add(Duration(hours: 4))),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Cetvrti task'),
              completed: Value(true),
              startDate: Value(DateTime.now().add(Duration(hours: 1))),
              endDate: Value(DateTime.now().add(Duration(hours: 2))),
              notes: Value('Opis cetvrtog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Peti task'),
              completed: Value(true),
              startDate: Value(DateTime.now().add(Duration(hours: 4))),
              endDate: Value(DateTime.now().add(Duration(hours: 6))),
              notes: Value('Opis petog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Sesti task'),
              completed: Value(false),
              startDate: Value(DateTime.now().add(Duration(hours: 1))),
              endDate: Value(DateTime.now().add(Duration(hours: 2))),
              notes: Value('Opis sestog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Sutrasnji task'),
              completed: Value(false),
              startDate: Value(DateTime.now().add(Duration(days: 1))),
              endDate: Value(DateTime.now().add(Duration(days: 1, hours: 2))),
              notes: Value('Opis sutrasnjeg taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Sutrasnji task 2'),
              completed: Value(false),
              allDayTask: Value(true),
              startDate: Value(DateTime.now().add(Duration(days: 1))),
              endDate: Value(DateTime.now().add(Duration(days: 1, hours: 2))),
              notes: Value('Opis sutrasnjeg celodnevnog taska'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Danasnji celodnevni task'),
              completed: Value(false),
              allDayTask: Value(true),
              startDate: Value(DateTime.now()),
              endDate: Value(DateTime.now()),
              notes: Value(
                  'Opis danasnjeg celodnevnog taska sa izuzetno dugim opisom, koji je tu da bi se videlo prikazivanje dugog teksta - Opis danasnjeg celodnevnog'),
            ));

            await into(tasks).insert(TasksCompanion(
              title: Value('Task bez opisa'),
              completed: Value(false),
              allDayTask: Value(true),
              startDate: Value(DateTime.now()),
              endDate: Value(DateTime.now()),
            ));

            await into(notifications).insert(NotificationsCompanion(
              dateAndTime: Value(DateTime.now()),
              taskId: Value(1),
            ));

            await into(notifications).insert(NotificationsCompanion(
              dateAndTime:
                  Value(DateTime.now().subtract(Duration(minutes: 30))),
              taskId: Value(1),
            ));

            await into(notifications).insert(NotificationsCompanion(
              dateAndTime:
                  Value(DateTime.now().subtract(Duration(minutes: 10))),
              taskId: Value(1),
            ));
          }
        },
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}
