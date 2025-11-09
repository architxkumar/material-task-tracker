// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class TodoItems extends Table with TableInfo<TodoItems, TodoItemsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TodoItems(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_items';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItemsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItemsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  TodoItems createAlias(String alias) {
    return TodoItems(attachedDatabase, alias);
  }
}

class TodoItemsData extends DataClass implements Insertable<TodoItemsData> {
  final int id;
  final String content;
  final bool completed;
  const TodoItemsData({
    required this.id,
    required this.content,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  TodoItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemsCompanion(
      id: Value(id),
      content: Value(content),
      completed: Value(completed),
    );
  }

  factory TodoItemsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemsData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  TodoItemsData copyWith({int? id, String? content, bool? completed}) =>
      TodoItemsData(
        id: id ?? this.id,
        content: content ?? this.content,
        completed: completed ?? this.completed,
      );
  TodoItemsData copyWithCompanion(TodoItemsCompanion data) {
    return TodoItemsData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItemsData &&
          other.id == this.id &&
          other.content == this.content &&
          other.completed == this.completed);
}

class TodoItemsCompanion extends UpdateCompanion<TodoItemsData> {
  final Value<int> id;
  final Value<String> content;
  final Value<bool> completed;
  const TodoItemsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TodoItemsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.completed = const Value.absent(),
  }) : content = Value(content);
  static Insertable<TodoItemsData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (completed != null) 'completed': completed,
    });
  }

  TodoItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<bool>? completed,
  }) {
    return TodoItemsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final TodoItems todoItems = TodoItems(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItems];
  @override
  int get schemaVersion => 1;
}
