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
import '../coach/coach_note.dart' as _iy0ledlp;

/// A read-only link that lets a coach see a user's progress and leave notes.
abstract class CoachShare
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CoachShare._({
    this.id,
    required this.authUserId,
    required this.code,
    required this.label,
    DateTime? createdAt,
    this.revokedAt,
    int? viewCount,
    this.lastViewedAt,
    this.notes,
  }) : createdAt = createdAt ?? DateTime.now(),
       viewCount = viewCount ?? 0;

  factory CoachShare({
    int? id,
    required _is.UuidValue authUserId,
    required String code,
    required String label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  }) = _CoachShareImpl;

  factory CoachShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachShare(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      code: jsonSerialization['code'] as String,
      label: jsonSerialization['label'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      viewCount: jsonSerialization['viewCount'] as int?,
      lastViewedAt: jsonSerialization['lastViewedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastViewedAt'],
            ),
      notes: jsonSerialization['notes'] == null
          ? null
          : _id3zg6f1.Protocol().deserialize<List<_iy0ledlp.CoachNote>>(
              jsonSerialization['notes'],
            ),
    );
  }

  static final t = CoachShareTable();

  static const db = CoachShareRepository._();

  @override
  int? id;

  /// Owner of the shared progress (Serverpod auth user id).
  _is.UuidValue authUserId;

  /// Random, unguessable code used in the share link.
  String code;

  /// Who the link is for, e.g. "Coach Priya".
  String label;

  DateTime createdAt;

  DateTime? revokedAt;

  int viewCount;

  DateTime? lastViewedAt;

  List<_iy0ledlp.CoachNote>? notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CoachShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CoachShare copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? code,
    String? label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'label': label,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'label': label,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      if (notes != null)
        'notes': notes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CoachShareInclude include({_iy0ledlp.CoachNoteIncludeList? notes}) {
    return CoachShareInclude._(notes: notes);
  }

  static CoachShareIncludeList includeList({
    _is.WhereExpressionBuilder<CoachShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    CoachShareInclude? include,
  }) {
    return CoachShareIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachShareImpl extends CoachShare {
  _CoachShareImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String code,
    required String label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  }) : super._(
         id: id,
         authUserId: authUserId,
         code: code,
         label: label,
         createdAt: createdAt,
         revokedAt: revokedAt,
         viewCount: viewCount,
         lastViewedAt: lastViewedAt,
         notes: notes,
       );

  /// Returns a shallow copy of this [CoachShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CoachShare copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? code,
    String? label,
    DateTime? createdAt,
    Object? revokedAt = _Undefined,
    int? viewCount,
    Object? lastViewedAt = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CoachShare(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      code: code ?? this.code,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      viewCount: viewCount ?? this.viewCount,
      lastViewedAt: lastViewedAt is DateTime?
          ? lastViewedAt
          : this.lastViewedAt,
      notes: notes is List<_iy0ledlp.CoachNote>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CoachShareUpdateTable extends _is.UpdateTable<CoachShareTable> {
  CoachShareUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );

  _is.ColumnValue<int, int> viewCount(int value) => _is.ColumnValue(
    table.viewCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastViewedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastViewedAt,
        value,
      );
}

class CoachShareTable extends _is.Table<int?> {
  CoachShareTable({super.tableRelation}) : super(tableName: 'coach_share') {
    updateTable = CoachShareUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    label = _is.ColumnString(
      'label',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
    viewCount = _is.ColumnInt(
      'viewCount',
      this,
      hasDefault: true,
    );
    lastViewedAt = _is.ColumnDateTime(
      'lastViewedAt',
      this,
    );
  }

  late final CoachShareUpdateTable updateTable;

  /// Owner of the shared progress (Serverpod auth user id).
  late final _is.ColumnUuid authUserId;

  /// Random, unguessable code used in the share link.
  late final _is.ColumnString code;

  /// Who the link is for, e.g. "Coach Priya".
  late final _is.ColumnString label;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime revokedAt;

  late final _is.ColumnInt viewCount;

  late final _is.ColumnDateTime lastViewedAt;

  _iy0ledlp.CoachNoteTable? ___notes;

  _is.ManyRelation<_iy0ledlp.CoachNoteTable>? _notes;

  _iy0ledlp.CoachNoteTable get __notes {
    if (___notes != null) return ___notes!;
    ___notes = _is.createRelationTable(
      relationFieldName: '__notes',
      field: CoachShare.t.id,
      foreignField: _iy0ledlp.CoachNote.t.shareId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iy0ledlp.CoachNoteTable(tableRelation: foreignTableRelation),
    );
    return ___notes!;
  }

  _is.ManyRelation<_iy0ledlp.CoachNoteTable> get notes {
    if (_notes != null) return _notes!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'notes',
      field: CoachShare.t.id,
      foreignField: _iy0ledlp.CoachNote.t.shareId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iy0ledlp.CoachNoteTable(tableRelation: foreignTableRelation),
    );
    _notes = _is.ManyRelation<_iy0ledlp.CoachNoteTable>(
      tableWithRelations: relationTable,
      table: _iy0ledlp.CoachNoteTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _notes!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    code,
    label,
    createdAt,
    revokedAt,
    viewCount,
    lastViewedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'notes') {
      return __notes;
    }
    return null;
  }
}

class CoachShareInclude extends _is.IncludeObject {
  CoachShareInclude._({_iy0ledlp.CoachNoteIncludeList? notes}) {
    _notes = notes;
  }

  _iy0ledlp.CoachNoteIncludeList? _notes;

  @override
  Map<String, _is.Include?> get includes => {'notes': _notes};

  @override
  _is.Table<int?> get table => CoachShare.t;
}

class CoachShareIncludeList extends _is.IncludeList {
  CoachShareIncludeList._({
    _is.WhereExpressionBuilder<CoachShareTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CoachShare.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CoachShare.t;
}

class CoachShareRepository {
  const CoachShareRepository._();

  final attach = const CoachShareAttachRepository._();

  final attachRow = const CoachShareAttachRowRepository._();

  /// Returns a list of [CoachShare]s matching the given query parameters.
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
  Future<List<CoachShare>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    _is.Transaction? transaction,
    CoachShareInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CoachShare>(
      where: where?.call(CoachShare.t),
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CoachShare] matching the given query parameters.
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
  Future<CoachShare?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachShareTable>? where,
    int? offset,
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    _is.Transaction? transaction,
    CoachShareInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CoachShare>(
      where: where?.call(CoachShare.t),
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CoachShare] by its [id] or null if no such row exists.
  Future<CoachShare?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CoachShareInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CoachShare>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CoachShare]s in the list and returns the inserted rows.
  ///
  /// The returned [CoachShare]s will have their `id` fields set.
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
  Future<List<CoachShare>> insert(
    _is.DatabaseSession session,
    List<CoachShare> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CoachShare>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CoachShare] and returns the inserted row.
  ///
  /// The returned [CoachShare] will have its `id` field set.
  Future<CoachShare> insertRow(
    _is.DatabaseSession session,
    CoachShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CoachShare>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CoachShare]s in the list and returns the resulting rows.
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
  /// The returned [CoachShare]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachShare>> upsert(
    _is.DatabaseSession session,
    List<CoachShare> rows, {
    required _is.ColumnSelections<CoachShareTable> conflictColumns,
    _is.ColumnSelections<CoachShareTable>? updateColumns,
    _is.WhereExpressionBuilder<CoachShareTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CoachShare>(
      rows,
      conflictColumns: conflictColumns(CoachShare.t),
      updateColumns: updateColumns?.call(CoachShare.t),
      updateWhere: updateWhere?.call(CoachShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CoachShare] and returns the resulting row.
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
  /// The returned [CoachShare] will have its `id` field set.
  Future<CoachShare?> upsertRow(
    _is.DatabaseSession session,
    CoachShare row, {
    required _is.ColumnSelections<CoachShareTable> conflictColumns,
    _is.ColumnSelections<CoachShareTable>? updateColumns,
    _is.WhereExpressionBuilder<CoachShareTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CoachShare>(
      row,
      conflictColumns: conflictColumns(CoachShare.t),
      updateColumns: updateColumns?.call(CoachShare.t),
      updateWhere: updateWhere?.call(CoachShare.t),
      transaction: transaction,
    );
  }

  /// Updates all [CoachShare]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachShare>> update(
    _is.DatabaseSession session,
    List<CoachShare> rows, {
    _is.ColumnSelections<CoachShareTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CoachShare>(
      rows,
      columns: columns?.call(CoachShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CoachShare]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CoachShare> updateRow(
    _is.DatabaseSession session,
    CoachShare row, {
    _is.ColumnSelections<CoachShareTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CoachShare>(
      row,
      columns: columns?.call(CoachShare.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CoachShare] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CoachShare?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CoachShareUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CoachShare>(
      id,
      columnValues: columnValues(CoachShare.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CoachShare]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachShare>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CoachShareUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CoachShareTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CoachShare>(
      columnValues: columnValues(CoachShare.t.updateTable),
      where: where(CoachShare.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CoachShare]s in the list and returns the deleted rows.
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
  Future<List<CoachShare>> delete(
    _is.DatabaseSession session,
    List<CoachShare> rows, {
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CoachShare>(
      rows,
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CoachShare].
  Future<CoachShare> deleteRow(
    _is.DatabaseSession session,
    CoachShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CoachShare>(
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
  Future<List<CoachShare>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CoachShareTable> where,
    _is.OrderByBuilder<CoachShareTable>? orderBy,
    _is.OrderByListBuilder<CoachShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CoachShare>(
      where: where(CoachShare.t),
      orderBy: orderBy?.call(CoachShare.t),
      orderByList: orderByList?.call(CoachShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachShareTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CoachShare>(
      where: where?.call(CoachShare.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CoachShare] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CoachShareTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CoachShare>(
      where: where(CoachShare.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CoachShareAttachRepository {
  const CoachShareAttachRepository._();

  /// Creates a relation between this [CoachShare] and the given [CoachNote]s
  /// by setting each [CoachNote]'s foreign key `shareId` to refer to this [CoachShare].
  Future<void> notes(
    _is.DatabaseSession session,
    CoachShare coachShare,
    List<_iy0ledlp.CoachNote> coachNote, {
    _is.Transaction? transaction,
  }) async {
    if (coachNote.any((e) => e.id == null)) {
      throw ArgumentError.notNull('coachNote.id');
    }
    if (coachShare.id == null) {
      throw ArgumentError.notNull('coachShare.id');
    }

    var $coachNote = coachNote
        .map((e) => e.copyWith(shareId: coachShare.id))
        .toList();
    await session.db.update<_iy0ledlp.CoachNote>(
      $coachNote,
      columns: [_iy0ledlp.CoachNote.t.shareId],
      transaction: transaction,
    );
  }
}

class CoachShareAttachRowRepository {
  const CoachShareAttachRowRepository._();

  /// Creates a relation between this [CoachShare] and the given [CoachNote]
  /// by setting the [CoachNote]'s foreign key `shareId` to refer to this [CoachShare].
  Future<void> notes(
    _is.DatabaseSession session,
    CoachShare coachShare,
    _iy0ledlp.CoachNote coachNote, {
    _is.Transaction? transaction,
  }) async {
    if (coachNote.id == null) {
      throw ArgumentError.notNull('coachNote.id');
    }
    if (coachShare.id == null) {
      throw ArgumentError.notNull('coachShare.id');
    }

    var $coachNote = coachNote.copyWith(shareId: coachShare.id);
    await session.db.updateRow<_iy0ledlp.CoachNote>(
      $coachNote,
      columns: [_iy0ledlp.CoachNote.t.shareId],
      transaction: transaction,
    );
  }
}
