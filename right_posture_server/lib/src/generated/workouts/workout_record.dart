/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:right_posture_server/src/generated/protocol.dart' as _id3zg6f1;
import 'package:serverpod/serverpod.dart' as _is;
import '../workouts/workout_set_record.dart' as _i2xuzwpe;

/// A finished workout synced from a user's phone. Only bounded summary
/// evidence is stored; camera frames and pose landmarks never leave the device.
abstract class WorkoutRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WorkoutRecord._({
    this.id,
    required this.authUserId,
    required this.clientId,
    required this.completedAt,
    this.note,
    required this.setCount,
    required this.totalReps,
    this.averageFormScore,
    required this.payload,
    this.sets,
    DateTime? uploadedAt,
  }) : uploadedAt = uploadedAt ?? DateTime.now();

  factory WorkoutRecord({
    int? id,
    required _is.UuidValue authUserId,
    required String clientId,
    required DateTime completedAt,
    String? note,
    required int setCount,
    required int totalReps,
    double? averageFormScore,
    required String payload,
    List<_i2xuzwpe.WorkoutSetRecord>? sets,
    DateTime? uploadedAt,
  }) = _WorkoutRecordImpl;

  factory WorkoutRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutRecord(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      clientId: jsonSerialization['clientId'] as String,
      completedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      note: jsonSerialization['note'] as String?,
      setCount: jsonSerialization['setCount'] as int,
      totalReps: jsonSerialization['totalReps'] as int,
      averageFormScore: (jsonSerialization['averageFormScore'] as num?)
          ?.toDouble(),
      payload: jsonSerialization['payload'] as String,
      sets: jsonSerialization['sets'] == null
          ? null
          : _id3zg6f1.Protocol().deserialize<List<_i2xuzwpe.WorkoutSetRecord>>(
              jsonSerialization['sets'],
            ),
      uploadedAt: jsonSerialization['uploadedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
    );
  }

  static final t = WorkoutRecordTable();

  static const db = WorkoutRecordRepository._();

  @override
  int? id;

  /// Owner of the workout (Serverpod auth user id).
  _is.UuidValue authUserId;

  /// Stable id assigned by the app, used to make uploads idempotent.
  String clientId;

  DateTime completedAt;

  String? note;

  int setCount;

  int totalReps;

  /// Average form score across scored sets, if any set was scored.
  double? averageFormScore;

  /// Versioned summary JSON produced by the shared core engine.
  String payload;

  /// Per-set rows for querying; loaded with `include`.
  List<_i2xuzwpe.WorkoutSetRecord>? sets;

  DateTime uploadedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkoutRecord copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? clientId,
    DateTime? completedAt,
    String? note,
    int? setCount,
    int? totalReps,
    double? averageFormScore,
    String? payload,
    List<_i2xuzwpe.WorkoutSetRecord>? sets,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutRecord',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'clientId': clientId,
      'completedAt': completedAt.toJson(),
      if (note != null) 'note': note,
      'setCount': setCount,
      'totalReps': totalReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      'payload': payload,
      if (sets != null) 'sets': sets?.toJson(valueToJson: (v) => v.toJson()),
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutRecord',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'clientId': clientId,
      'completedAt': completedAt.toJson(),
      if (note != null) 'note': note,
      'setCount': setCount,
      'totalReps': totalReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      'payload': payload,
      if (sets != null)
        'sets': sets?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  static WorkoutRecordInclude include({
    _i2xuzwpe.WorkoutSetRecordIncludeList? sets,
  }) {
    return WorkoutRecordInclude._(sets: sets);
  }

  static WorkoutRecordIncludeList includeList({
    _is.WhereExpressionBuilder<WorkoutRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    WorkoutRecordInclude? include,
  }) {
    return WorkoutRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutRecordImpl extends WorkoutRecord {
  _WorkoutRecordImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String clientId,
    required DateTime completedAt,
    String? note,
    required int setCount,
    required int totalReps,
    double? averageFormScore,
    required String payload,
    List<_i2xuzwpe.WorkoutSetRecord>? sets,
    DateTime? uploadedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         clientId: clientId,
         completedAt: completedAt,
         note: note,
         setCount: setCount,
         totalReps: totalReps,
         averageFormScore: averageFormScore,
         payload: payload,
         sets: sets,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [WorkoutRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkoutRecord copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? clientId,
    DateTime? completedAt,
    Object? note = _Undefined,
    int? setCount,
    int? totalReps,
    Object? averageFormScore = _Undefined,
    String? payload,
    Object? sets = _Undefined,
    DateTime? uploadedAt,
  }) {
    return WorkoutRecord(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      clientId: clientId ?? this.clientId,
      completedAt: completedAt ?? this.completedAt,
      note: note is String? ? note : this.note,
      setCount: setCount ?? this.setCount,
      totalReps: totalReps ?? this.totalReps,
      averageFormScore: averageFormScore is double?
          ? averageFormScore
          : this.averageFormScore,
      payload: payload ?? this.payload,
      sets: sets is List<_i2xuzwpe.WorkoutSetRecord>?
          ? sets
          : this.sets?.map((e0) => e0.copyWith()).toList(),
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}

class WorkoutRecordUpdateTable extends _is.UpdateTable<WorkoutRecordTable> {
  WorkoutRecordUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> clientId(String value) => _is.ColumnValue(
    table.clientId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<int, int> setCount(int value) => _is.ColumnValue(
    table.setCount,
    value,
  );

  _is.ColumnValue<int, int> totalReps(int value) => _is.ColumnValue(
    table.totalReps,
    value,
  );

  _is.ColumnValue<double, double> averageFormScore(double? value) =>
      _is.ColumnValue(
        table.averageFormScore,
        value,
      );

  _is.ColumnValue<String, String> payload(String value) => _is.ColumnValue(
    table.payload,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> uploadedAt(DateTime value) =>
      _is.ColumnValue(
        table.uploadedAt,
        value,
      );
}

class WorkoutRecordTable extends _is.Table<int?> {
  WorkoutRecordTable({super.tableRelation})
    : super(tableName: 'workout_record') {
    updateTable = WorkoutRecordUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    clientId = _is.ColumnString(
      'clientId',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    setCount = _is.ColumnInt(
      'setCount',
      this,
    );
    totalReps = _is.ColumnInt(
      'totalReps',
      this,
    );
    averageFormScore = _is.ColumnDouble(
      'averageFormScore',
      this,
    );
    payload = _is.ColumnString(
      'payload',
      this,
    );
    uploadedAt = _is.ColumnDateTime(
      'uploadedAt',
      this,
      hasDefault: true,
    );
  }

  late final WorkoutRecordUpdateTable updateTable;

  /// Owner of the workout (Serverpod auth user id).
  late final _is.ColumnUuid authUserId;

  /// Stable id assigned by the app, used to make uploads idempotent.
  late final _is.ColumnString clientId;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnString note;

  late final _is.ColumnInt setCount;

  late final _is.ColumnInt totalReps;

  /// Average form score across scored sets, if any set was scored.
  late final _is.ColumnDouble averageFormScore;

  /// Versioned summary JSON produced by the shared core engine.
  late final _is.ColumnString payload;

  /// Per-set rows for querying; loaded with `include`.
  _i2xuzwpe.WorkoutSetRecordTable? ___sets;

  /// Per-set rows for querying; loaded with `include`.
  _is.ManyRelation<_i2xuzwpe.WorkoutSetRecordTable>? _sets;

  late final _is.ColumnDateTime uploadedAt;

  _i2xuzwpe.WorkoutSetRecordTable get __sets {
    if (___sets != null) return ___sets!;
    ___sets = _is.createRelationTable(
      relationFieldName: '__sets',
      field: WorkoutRecord.t.id,
      foreignField: _i2xuzwpe.WorkoutSetRecord.t.workoutId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2xuzwpe.WorkoutSetRecordTable(tableRelation: foreignTableRelation),
    );
    return ___sets!;
  }

  _is.ManyRelation<_i2xuzwpe.WorkoutSetRecordTable> get sets {
    if (_sets != null) return _sets!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'sets',
      field: WorkoutRecord.t.id,
      foreignField: _i2xuzwpe.WorkoutSetRecord.t.workoutId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2xuzwpe.WorkoutSetRecordTable(tableRelation: foreignTableRelation),
    );
    _sets = _is.ManyRelation<_i2xuzwpe.WorkoutSetRecordTable>(
      tableWithRelations: relationTable,
      table: _i2xuzwpe.WorkoutSetRecordTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _sets!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    clientId,
    completedAt,
    note,
    setCount,
    totalReps,
    averageFormScore,
    payload,
    uploadedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'sets') {
      return __sets;
    }
    return null;
  }
}

class WorkoutRecordInclude extends _is.IncludeObject {
  WorkoutRecordInclude._({_i2xuzwpe.WorkoutSetRecordIncludeList? sets}) {
    _sets = sets;
  }

  _i2xuzwpe.WorkoutSetRecordIncludeList? _sets;

  @override
  Map<String, _is.Include?> get includes => {'sets': _sets};

  @override
  _is.Table<int?> get table => WorkoutRecord.t;
}

class WorkoutRecordIncludeList extends _is.IncludeList {
  WorkoutRecordIncludeList._({
    _is.WhereExpressionBuilder<WorkoutRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorkoutRecord.t;
}

class WorkoutRecordRepository {
  const WorkoutRecordRepository._();

  final attach = const WorkoutRecordAttachRepository._();

  final attachRow = const WorkoutRecordAttachRowRepository._();

  /// Returns a list of [WorkoutRecord]s matching the given query parameters.
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
  Future<List<WorkoutRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    _is.Transaction? transaction,
    WorkoutRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutRecord>(
      where: where?.call(WorkoutRecord.t),
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutRecord] matching the given query parameters.
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
  Future<WorkoutRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    _is.Transaction? transaction,
    WorkoutRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutRecord>(
      where: where?.call(WorkoutRecord.t),
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutRecord] by its [id] or null if no such row exists.
  Future<WorkoutRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    WorkoutRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutRecord]s will have their `id` fields set.
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
  Future<List<WorkoutRecord>> insert(
    _is.DatabaseSession session,
    List<WorkoutRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorkoutRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorkoutRecord] and returns the inserted row.
  ///
  /// The returned [WorkoutRecord] will have its `id` field set.
  Future<WorkoutRecord> insertRow(
    _is.DatabaseSession session,
    WorkoutRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorkoutRecord]s in the list and returns the resulting rows.
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
  /// The returned [WorkoutRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutRecord>> upsert(
    _is.DatabaseSession session,
    List<WorkoutRecord> rows, {
    required _is.ColumnSelections<WorkoutRecordTable> conflictColumns,
    _is.ColumnSelections<WorkoutRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorkoutRecord>(
      rows,
      conflictColumns: conflictColumns(WorkoutRecord.t),
      updateColumns: updateColumns?.call(WorkoutRecord.t),
      updateWhere: updateWhere?.call(WorkoutRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorkoutRecord] and returns the resulting row.
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
  /// The returned [WorkoutRecord] will have its `id` field set.
  Future<WorkoutRecord?> upsertRow(
    _is.DatabaseSession session,
    WorkoutRecord row, {
    required _is.ColumnSelections<WorkoutRecordTable> conflictColumns,
    _is.ColumnSelections<WorkoutRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<WorkoutRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorkoutRecord>(
      row,
      conflictColumns: conflictColumns(WorkoutRecord.t),
      updateColumns: updateColumns?.call(WorkoutRecord.t),
      updateWhere: updateWhere?.call(WorkoutRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutRecord>> update(
    _is.DatabaseSession session,
    List<WorkoutRecord> rows, {
    _is.ColumnSelections<WorkoutRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorkoutRecord>(
      rows,
      columns: columns?.call(WorkoutRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorkoutRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutRecord> updateRow(
    _is.DatabaseSession session,
    WorkoutRecord row, {
    _is.ColumnSelections<WorkoutRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutRecord>(
      row,
      columns: columns?.call(WorkoutRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorkoutRecordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutRecord>(
      id,
      columnValues: columnValues(WorkoutRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorkoutRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorkoutRecordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WorkoutRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorkoutRecord>(
      columnValues: columnValues(WorkoutRecord.t.updateTable),
      where: where(WorkoutRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorkoutRecord]s in the list and returns the deleted rows.
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
  Future<List<WorkoutRecord>> delete(
    _is.DatabaseSession session,
    List<WorkoutRecord> rows, {
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorkoutRecord>(
      rows,
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorkoutRecord].
  Future<WorkoutRecord> deleteRow(
    _is.DatabaseSession session,
    WorkoutRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutRecord>(
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
  Future<List<WorkoutRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutRecordTable> where,
    _is.OrderByBuilder<WorkoutRecordTable>? orderBy,
    _is.OrderByListBuilder<WorkoutRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorkoutRecord>(
      where: where(WorkoutRecord.t),
      orderBy: orderBy?.call(WorkoutRecord.t),
      orderByList: orderByList?.call(WorkoutRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorkoutRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutRecord>(
      where: where?.call(WorkoutRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorkoutRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutRecord>(
      where: where(WorkoutRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class WorkoutRecordAttachRepository {
  const WorkoutRecordAttachRepository._();

  /// Creates a relation between this [WorkoutRecord] and the given [WorkoutSetRecord]s
  /// by setting each [WorkoutSetRecord]'s foreign key `workoutId` to refer to this [WorkoutRecord].
  Future<void> sets(
    _is.DatabaseSession session,
    WorkoutRecord workoutRecord,
    List<_i2xuzwpe.WorkoutSetRecord> workoutSetRecord, {
    _is.Transaction? transaction,
  }) async {
    if (workoutSetRecord.any((e) => e.id == null)) {
      throw ArgumentError.notNull('workoutSetRecord.id');
    }
    if (workoutRecord.id == null) {
      throw ArgumentError.notNull('workoutRecord.id');
    }

    var $workoutSetRecord = workoutSetRecord
        .map((e) => e.copyWith(workoutId: workoutRecord.id))
        .toList();
    await session.db.update<_i2xuzwpe.WorkoutSetRecord>(
      $workoutSetRecord,
      columns: [_i2xuzwpe.WorkoutSetRecord.t.workoutId],
      transaction: transaction,
    );
  }
}

class WorkoutRecordAttachRowRepository {
  const WorkoutRecordAttachRowRepository._();

  /// Creates a relation between this [WorkoutRecord] and the given [WorkoutSetRecord]
  /// by setting the [WorkoutSetRecord]'s foreign key `workoutId` to refer to this [WorkoutRecord].
  Future<void> sets(
    _is.DatabaseSession session,
    WorkoutRecord workoutRecord,
    _i2xuzwpe.WorkoutSetRecord workoutSetRecord, {
    _is.Transaction? transaction,
  }) async {
    if (workoutSetRecord.id == null) {
      throw ArgumentError.notNull('workoutSetRecord.id');
    }
    if (workoutRecord.id == null) {
      throw ArgumentError.notNull('workoutRecord.id');
    }

    var $workoutSetRecord = workoutSetRecord.copyWith(
      workoutId: workoutRecord.id,
    );
    await session.db.updateRow<_i2xuzwpe.WorkoutSetRecord>(
      $workoutSetRecord,
      columns: [_i2xuzwpe.WorkoutSetRecord.t.workoutId],
      transaction: transaction,
    );
  }
}
