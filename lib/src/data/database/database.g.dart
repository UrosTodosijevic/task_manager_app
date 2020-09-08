// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String notes;
  final bool allDayTask;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;
  Task(
      {@required this.id,
      @required this.title,
      this.notes,
      @required this.allDayTask,
      @required this.startDate,
      @required this.endDate,
      @required this.completed});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      allDayTask: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}all_day_task']),
      startDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      endDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_date']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || allDayTask != null) {
      map['all_day_task'] = Variable<bool>(allDayTask);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      allDayTask: allDayTask == null && nullToAbsent
          ? const Value.absent()
          : Value(allDayTask),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      allDayTask: serializer.fromJson<bool>(json['allDayTask']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'allDayTask': serializer.toJson<bool>(allDayTask),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  Task copyWith(
          {int id,
          String title,
          String notes,
          bool allDayTask,
          DateTime startDate,
          DateTime endDate,
          bool completed}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        allDayTask: allDayTask ?? this.allDayTask,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('allDayTask: $allDayTask, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              notes.hashCode,
              $mrjc(
                  allDayTask.hashCode,
                  $mrjc(startDate.hashCode,
                      $mrjc(endDate.hashCode, completed.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.allDayTask == this.allDayTask &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.completed == this.completed);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> notes;
  final Value<bool> allDayTask;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> completed;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.allDayTask = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.notes = const Value.absent(),
    this.allDayTask = const Value.absent(),
    @required DateTime startDate,
    @required DateTime endDate,
    this.completed = const Value.absent(),
  })  : title = Value(title),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> notes,
    Expression<bool> allDayTask,
    Expression<DateTime> startDate,
    Expression<DateTime> endDate,
    Expression<bool> completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (allDayTask != null) 'all_day_task': allDayTask,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (completed != null) 'completed': completed,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> notes,
      Value<bool> allDayTask,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> completed}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      allDayTask: allDayTask ?? this.allDayTask,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (allDayTask.present) {
      map['all_day_task'] = Variable<bool>(allDayTask.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('allDayTask: $allDayTask, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 6, maxTextLength: 32);
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn('notes', $tableName, true, maxTextLength: 160);
  }

  final VerificationMeta _allDayTaskMeta = const VerificationMeta('allDayTask');
  GeneratedBoolColumn _allDayTask;
  @override
  GeneratedBoolColumn get allDayTask => _allDayTask ??= _constructAllDayTask();
  GeneratedBoolColumn _constructAllDayTask() {
    return GeneratedBoolColumn('all_day_task', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  GeneratedDateTimeColumn _startDate;
  @override
  GeneratedDateTimeColumn get startDate => _startDate ??= _constructStartDate();
  GeneratedDateTimeColumn _constructStartDate() {
    return GeneratedDateTimeColumn(
      'start_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  GeneratedDateTimeColumn _endDate;
  @override
  GeneratedDateTimeColumn get endDate => _endDate ??= _constructEndDate();
  GeneratedDateTimeColumn _constructEndDate() {
    return GeneratedDateTimeColumn(
      'end_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, notes, allDayTask, startDate, endDate, completed];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    if (data.containsKey('all_day_task')) {
      context.handle(
          _allDayTaskMeta,
          allDayTask.isAcceptableOrUnknown(
              data['all_day_task'], _allDayTaskMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date'], _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date'], _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final DateTime dateAndTime;
  final int taskId;
  Notification(
      {@required this.id, @required this.dateAndTime, @required this.taskId});
  factory Notification.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Notification(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dateAndTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_and_time']),
      taskId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}task_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || dateAndTime != null) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime);
    }
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<int>(taskId);
    }
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dateAndTime: dateAndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAndTime),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      dateAndTime: serializer.fromJson<DateTime>(json['dateAndTime']),
      taskId: serializer.fromJson<int>(json['taskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateAndTime': serializer.toJson<DateTime>(dateAndTime),
      'taskId': serializer.toJson<int>(taskId),
    };
  }

  Notification copyWith({int id, DateTime dateAndTime, int taskId}) =>
      Notification(
        id: id ?? this.id,
        dateAndTime: dateAndTime ?? this.dateAndTime,
        taskId: taskId ?? this.taskId,
      );
  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(dateAndTime.hashCode, taskId.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.dateAndTime == this.dateAndTime &&
          other.taskId == this.taskId);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<DateTime> dateAndTime;
  final Value<int> taskId;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.taskId = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime dateAndTime,
    @required int taskId,
  })  : dateAndTime = Value(dateAndTime),
        taskId = Value(taskId);
  static Insertable<Notification> custom({
    Expression<int> id,
    Expression<DateTime> dateAndTime,
    Expression<int> taskId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (taskId != null) 'task_id': taskId,
    });
  }

  NotificationsCompanion copyWith(
      {Value<int> id, Value<DateTime> dateAndTime, Value<int> taskId}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      taskId: taskId ?? this.taskId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotificationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateAndTimeMeta =
      const VerificationMeta('dateAndTime');
  GeneratedDateTimeColumn _dateAndTime;
  @override
  GeneratedDateTimeColumn get dateAndTime =>
      _dateAndTime ??= _constructDateAndTime();
  GeneratedDateTimeColumn _constructDateAndTime() {
    return GeneratedDateTimeColumn(
      'date_and_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  GeneratedIntColumn _taskId;
  @override
  GeneratedIntColumn get taskId => _taskId ??= _constructTaskId();
  GeneratedIntColumn _constructTaskId() {
    return GeneratedIntColumn('task_id', $tableName, false,
        $customConstraints: 'REFERENCES tasks(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, dateAndTime, taskId];
  @override
  $NotificationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notifications';
  @override
  final String actualTableName = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
          _dateAndTimeMeta,
          dateAndTime.isAcceptableOrUnknown(
              data['date_and_time'], _dateAndTimeMeta));
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id'], _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Notification.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $NotificationsTable _notifications;
  $NotificationsTable get notifications =>
      _notifications ??= $NotificationsTable(this);
  TasksDao _tasksDao;
  TasksDao get tasksDao => _tasksDao ??= TasksDao(this as AppDatabase);
  NotificationsDao _notificationsDao;
  NotificationsDao get notificationsDao =>
      _notificationsDao ??= NotificationsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, notifications];
}
