/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// One exercise set inside a synced workout.
abstract class WorkoutSetRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutSetRecord._({
    this.id,
    required this.workoutId,
    required this.authUserId,
    required this.exercise,
    required this.completedAt,
    required this.totalReps,
    required this.goodReps,
    required this.warningReps,
    required this.degradedReps,
    this.formScore,
    this.consistencyScore,
    this.degradationStartRep,
  });

  factory WorkoutSetRecord({
    int? id,
    required int workoutId,
    required _is.UuidValue authUserId,
    required String exercise,
    required DateTime completedAt,
    required int totalReps,
    required int goodReps,
    required int warningReps,
    required int degradedReps,
    double? formScore,
    double? consistencyScore,
    int? degradationStartRep,
  }) = _WorkoutSetRecordImpl;

  factory WorkoutSetRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSetRecord(
      id: jsonSerialization['id'] as int?,
      workoutId: jsonSerialization['workoutId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      exercise: jsonSerialization['exercise'] as String,
      completedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      totalReps: jsonSerialization['totalReps'] as int,
      goodReps: jsonSerialization['goodReps'] as int,
      warningReps: jsonSerialization['warningReps'] as int,
      degradedReps: jsonSerialization['degradedReps'] as int,
      formScore: (jsonSerialization['formScore'] as num?)?.toDouble(),
      consistencyScore: (jsonSerialization['consistencyScore'] as num?)
          ?.toDouble(),
      degradationStartRep: jsonSerialization['degradationStartRep'] as int?,
    );
  }

  static final t = WorkoutSetRecordTable();

  static const db = WorkoutSetRecordRepository._();

  @override
  int? id;

  int workoutId;

  _is.UuidValue authUserId;

  String exercise;

  DateTime completedAt;

  int totalReps;

  int goodReps;

  int warningReps;

  int degradedReps;

  double? formScore;

  double? consistencyScore;

  int? degradationStartRep;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutSetRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutSetRecord copyWith({
    int? id,
    int? workoutId,
    _is.UuidValue? authUserId,
    String? exercise,
    DateTime? completedAt,
    int? totalReps,
    int? goodReps,
    int? warningReps,
    int? degradedReps,
    double? formScore,
    double? consistencyScore,
    int? degradationStartRep,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSetRecord',
      if (id != null) 'id': id,
      'workoutId': workoutId,
      'authUserId': authUserId.toJson(),
      'exercise': exercise,
      'completedAt': completedAt.toJson(),
      'totalReps': totalReps,
      'goodReps': goodReps,
      'warningReps': warningReps,
      'degradedReps': degradedReps,
      if (formScore != null) 'formScore': formScore,
      if (consistencyScore != null) 'consistencyScore': consistencyScore,
      if (degradationStartRep != null)
        'degradationStartRep': degradationStartRep,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutSetRecord',
      if (id != null) 'id': id,
      'workoutId': workoutId,
      'authUserId': authUserId.toJson(),
      'exercise': exercise,
      'completedAt': completedAt.toJson(),
      'totalReps': totalReps,
      'goodReps': goodReps,
      'warningReps': warningReps,
      'degradedReps': degradedReps,
      if (formScore != null) 'formScore': formScore,
      if (consistencyScore != null) 'consistencyScore': consistencyScore,
      if (degradationStartRep != null)
        'degradationStartRep': degradationStartRep,
    };
  }

  static WorkoutSetRecordInclude include() {
    return WorkoutSetRecordInclude._();
  }

  static WorkoutSetRecordIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    WorkoutSetRecordInclude? include,
  }) {
    return WorkoutSetRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSetRecordImpl extends WorkoutSetRecord {
  _WorkoutSetRecordImpl({
    int? id,
    required int workoutId,
    required _is.UuidValue authUserId,
    required String exercise,
    required DateTime completedAt,
    required int totalReps,
    required int goodReps,
    required int warningReps,
    required int degradedReps,
    double? formScore,
    double? consistencyScore,
    int? degradationStartRep,
  }) : super._(
         id: id,
         workoutId: workoutId,
         authUserId: authUserId,
         exercise: exercise,
         completedAt: completedAt,
         totalReps: totalReps,
         goodReps: goodReps,
         warningReps: warningReps,
         degradedReps: degradedReps,
         formScore: formScore,
         consistencyScore: consistencyScore,
         degradationStartRep: degradationStartRep,
       );

  /// Returns a shallow copy of this [WorkoutSetRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutSetRecord copyWith({
    Object? id = _Undefined,
    int? workoutId,
    _is.UuidValue? authUserId,
    String? exercise,
    DateTime? completedAt,
    int? totalReps,
    int? goodReps,
    int? warningReps,
    int? degradedReps,
    Object? formScore = _Undefined,
    Object? consistencyScore = _Undefined,
    Object? degradationStartRep = _Undefined,
  }) {
    return WorkoutSetRecord(
      id: id is int? ? id : this.id,
      workoutId: workoutId ?? this.workoutId,
      authUserId: authUserId ?? this.authUserId,
      exercise: exercise ?? this.exercise,
      completedAt: completedAt ?? this.completedAt,
      totalReps: totalReps ?? this.totalReps,
      goodReps: goodReps ?? this.goodReps,
      warningReps: warningReps ?? this.warningReps,
      degradedReps: degradedReps ?? this.degradedReps,
      formScore: formScore is double? ? formScore : this.formScore,
      consistencyScore: consistencyScore is double?
          ? consistencyScore
          : this.consistencyScore,
      degradationStartRep: degradationStartRep is int?
          ? degradationStartRep
          : this.degradationStartRep,
    );
  }
}

class WorkoutSetRecordUpdateTable
    extends _is.UpdateTable<WorkoutSetRecordTable> {
  WorkoutSetRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> workoutId(int value) => _is.ColumnValue(
    table.workoutId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> exercise(String value) => _is.ColumnValue(
    table.exercise,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<int, int> totalReps(int value) => _is.ColumnValue(
    table.totalReps,
    value,
  );

  _is.ColumnValue<int, int> goodReps(int value) => _is.ColumnValue(
    table.goodReps,
    value,
  );

  _is.ColumnValue<int, int> warningReps(int value) => _is.ColumnValue(
    table.warningReps,
    value,
  );

  _is.ColumnValue<int, int> degradedReps(int value) => _is.ColumnValue(
    table.degradedReps,
    value,
  );

  _is.ColumnValue<double, double> formScore(double? value) => _is.ColumnValue(
    table.formScore,
    value,
  );

  _is.ColumnValue<double, double> consistencyScore(double? value) =>
      _is.ColumnValue(
        table.consistencyScore,
        value,
      );

  _is.ColumnValue<int, int> degradationStartRep(int? value) => _is.ColumnValue(
    table.degradationStartRep,
    value,
  );
}

class WorkoutSetRecordTable extends _is.Table<int?> {
  WorkoutSetRecordTable({super.tableRelation})
    : super(tableName: 'workout_set_record') {
    updateTable = WorkoutSetRecordUpdateTable(this);
    workoutId = _is.ColumnInt(
      'workoutId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    exercise = _is.ColumnString(
      'exercise',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    totalReps = _is.ColumnInt(
      'totalReps',
      this,
    );
    goodReps = _is.ColumnInt(
      'goodReps',
      this,
    );
    warningReps = _is.ColumnInt(
      'warningReps',
      this,
    );
    degradedReps = _is.ColumnInt(
      'degradedReps',
      this,
    );
    formScore = _is.ColumnDouble(
      'formScore',
      this,
    );
    consistencyScore = _is.ColumnDouble(
      'consistencyScore',
      this,
    );
    degradationStartRep = _is.ColumnInt(
      'degradationStartRep',
      this,
    );
  }

  late final WorkoutSetRecordUpdateTable updateTable;

  late final _is.ColumnInt workoutId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString exercise;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnInt totalReps;

  late final _is.ColumnInt goodReps;

  late final _is.ColumnInt warningReps;

  late final _is.ColumnInt degradedReps;

  late final _is.ColumnDouble formScore;

  late final _is.ColumnDouble consistencyScore;

  late final _is.ColumnInt degradationStartRep;

  @override
  List<_is.Column> get columns => [
    id,
    workoutId,
    authUserId,
    exercise,
    completedAt,
    totalReps,
    goodReps,
    warningReps,
    degradedReps,
    formScore,
    consistencyScore,
    degradationStartRep,
  ];
}

class WorkoutSetRecordInclude extends _is.IncludeObject {
  WorkoutSetRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorkoutSetRecord.t;
}

class WorkoutSetRecordIncludeList extends _is.IncludeList {
  WorkoutSetRecordIncludeList._({
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutSetRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutSetRecord.t;
}

class WorkoutSetRecordRepository {
  const WorkoutSetRecordRepository._();

  /// Returns a list of [WorkoutSetRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<WorkoutSetRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutSetRecord>(
      where: where?.call(WorkoutSetRecord.t),
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutSetRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<WorkoutSetRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutSetRecord>(
      where: where?.call(WorkoutSetRecord.t),
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutSetRecord] by its [id] or null if no such row exists.
  Future<WorkoutSetRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutSetRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutSetRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutSetRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> insert(
    _is.DatabaseSession session,
    List<WorkoutSetRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutSetRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutSetRecord] and returns the inserted row.
  ///
  /// The returned [WorkoutSetRecord] will have its `id` field set.
  Future<WorkoutSetRecord> insertRow(
    _is.DatabaseSession session,
    WorkoutSetRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutSetRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutSetRecord]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [WorkoutSetRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> upsert(
    _is.DatabaseSession session,
    List<WorkoutSetRecord> rows, {
    required _is.ColumnSelections<WorkoutSetRecordTable> conflictColumns,
    _is.ColumnSelections<WorkoutSetRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutSetRecord>(
      rows,
      conflictColumns: conflictColumns(WorkoutSetRecord.t),
      updateColumns: updateColumns?.call(WorkoutSetRecord.t),
      updateWhere: updateWhere?.call(WorkoutSetRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutSetRecord] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [WorkoutSetRecord] will have its `id` field set.
  Future<WorkoutSetRecord?> upsertRow(
    _is.DatabaseSession session,
    WorkoutSetRecord row, {
    required _is.ColumnSelections<WorkoutSetRecordTable> conflictColumns,
    _is.ColumnSelections<WorkoutSetRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutSetRecord>(
      row,
      conflictColumns: conflictColumns(WorkoutSetRecord.t),
      updateColumns: updateColumns?.call(WorkoutSetRecord.t),
      updateWhere: updateWhere?.call(WorkoutSetRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSetRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> update(
    _is.DatabaseSession session,
    List<WorkoutSetRecord> rows, {
    _is.ColumnSelections<WorkoutSetRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutSetRecord>(
      rows,
      columns: columns?.call(WorkoutSetRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutSetRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutSetRecord> updateRow(
    _is.DatabaseSession session,
    WorkoutSetRecord row, {
    _is.ColumnSelections<WorkoutSetRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutSetRecord>(
      row,
      columns: columns?.call(WorkoutSetRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSetRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutSetRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutSetRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutSetRecord>(
      id,
      columnValues: columnValues(WorkoutSetRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSetRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutSetRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<WorkoutSetRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutSetRecord>(
      columnValues: columnValues(WorkoutSetRecord.t.updateTable),
      where: where(WorkoutSetRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutSetRecord]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> delete(
    _is.DatabaseSession session,
    List<WorkoutSetRecord> rows, {
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutSetRecord>(
      rows,
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutSetRecord].
  Future<WorkoutSetRecord> deleteRow(
    _is.DatabaseSession session,
    WorkoutSetRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutSetRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutSetRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSetRecordTable> where,
    _is.OrderByBuilder<WorkoutSetRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutSetRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutSetRecord>(
      where: where(WorkoutSetRecord.t),
      orderBy: orderBy?.call(WorkoutSetRecord.t),
      orderByList: orderByList?.call(WorkoutSetRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutSetRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutSetRecord>(
      where: where?.call(WorkoutSetRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutSetRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutSetRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutSetRecord>(
      where: where(WorkoutSetRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
