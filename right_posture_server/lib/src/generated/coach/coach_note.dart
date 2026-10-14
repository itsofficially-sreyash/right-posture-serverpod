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

/// Feedback a coach left through a share link.
abstract class CoachNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CoachNote._({
    this.id,
    required this.shareId,
    required this.authorName,
    required this.message,
    DateTime? createdAt,
    this.readAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CoachNote({
    int? id,
    required int shareId,
    required String authorName,
    required String message,
    DateTime? createdAt,
    DateTime? readAt,
  }) = _CoachNoteImpl;

  factory CoachNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachNote(
      id: jsonSerialization['id'] as int?,
      shareId: jsonSerialization['shareId'] as int,
      authorName: jsonSerialization['authorName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
    );
  }

  static final t = CoachNoteTable();

  static const db = CoachNoteRepository._();

  @override
  int? id;

  int shareId;

  String authorName;

  String message;

  DateTime createdAt;

  DateTime? readAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CoachNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CoachNote copyWith({
    int? id,
    int? shareId,
    String? authorName,
    String? message,
    DateTime? createdAt,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachNote',
      if (id != null) 'id': id,
      'shareId': shareId,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachNote',
      if (id != null) 'id': id,
      'shareId': shareId,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  static CoachNoteInclude include() {
    return CoachNoteInclude._();
  }

  static CoachNoteIncludeList includeList({
    _is.WhereExpressionBuilder<CoachNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    CoachNoteInclude? include,
  }) {
    return CoachNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachNoteImpl extends CoachNote {
  _CoachNoteImpl({
    int? id,
    required int shareId,
    required String authorName,
    required String message,
    DateTime? createdAt,
    DateTime? readAt,
  }) : super._(
         id: id,
         shareId: shareId,
         authorName: authorName,
         message: message,
         createdAt: createdAt,
         readAt: readAt,
       );

  /// Returns a shallow copy of this [CoachNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CoachNote copyWith({
    Object? id = _Undefined,
    int? shareId,
    String? authorName,
    String? message,
    DateTime? createdAt,
    Object? readAt = _Undefined,
  }) {
    return CoachNote(
      id: id is int? ? id : this.id,
      shareId: shareId ?? this.shareId,
      authorName: authorName ?? this.authorName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt is DateTime? ? readAt : this.readAt,
    );
  }
}

class CoachNoteUpdateTable extends _is.UpdateTable<CoachNoteTable> {
  CoachNoteUpdateTable(super.table);

  _is.ColumnValue<int, int> shareId(int value) => _is.ColumnValue(
    table.shareId,
    value,
  );

  _is.ColumnValue<String, String> authorName(String value) => _is.ColumnValue(
    table.authorName,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> readAt(DateTime? value) =>
      _is.ColumnValue(
        table.readAt,
        value,
      );
}

class CoachNoteTable extends _is.Table<int?> {
  CoachNoteTable({super.tableRelation}) : super(tableName: 'coach_note') {
    updateTable = CoachNoteUpdateTable(this);
    shareId = _is.ColumnInt(
      'shareId',
      this,
    );
    authorName = _is.ColumnString(
      'authorName',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    readAt = _is.ColumnDateTime(
      'readAt',
      this,
    );
  }

  late final CoachNoteUpdateTable updateTable;

  late final _is.ColumnInt shareId;

  late final _is.ColumnString authorName;

  late final _is.ColumnString message;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime readAt;

  @override
  List<_is.Column> get columns => [
    id,
    shareId,
    authorName,
    message,
    createdAt,
    readAt,
  ];
}

class CoachNoteInclude extends _is.IncludeObject {
  CoachNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CoachNote.t;
}

class CoachNoteIncludeList extends _is.IncludeList {
  CoachNoteIncludeList._({
    _is.WhereExpressionBuilder<CoachNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CoachNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CoachNote.t;
}

class CoachNoteRepository {
  const CoachNoteRepository._();

  /// Returns a list of [CoachNote]s matching the given query parameters.
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
  Future<List<CoachNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CoachNote>(
      where: where?.call(CoachNote.t),
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CoachNote] matching the given query parameters.
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
  Future<CoachNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CoachNote>(
      where: where?.call(CoachNote.t),
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CoachNote] by its [id] or null if no such row exists.
  Future<CoachNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CoachNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CoachNote]s in the list and returns the inserted rows.
  ///
  /// The returned [CoachNote]s will have their `id` fields set.
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
  Future<List<CoachNote>> insert(
    _is.DatabaseSession session,
    List<CoachNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CoachNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CoachNote] and returns the inserted row.
  ///
  /// The returned [CoachNote] will have its `id` field set.
  Future<CoachNote> insertRow(
    _is.DatabaseSession session,
    CoachNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CoachNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CoachNote]s in the list and returns the resulting rows.
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
  /// The returned [CoachNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachNote>> upsert(
    _is.DatabaseSession session,
    List<CoachNote> rows, {
    required _is.ColumnSelections<CoachNoteTable> conflictColumns,
    _is.ColumnSelections<CoachNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<CoachNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CoachNote>(
      rows,
      conflictColumns: conflictColumns(CoachNote.t),
      updateColumns: updateColumns?.call(CoachNote.t),
      updateWhere: updateWhere?.call(CoachNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CoachNote] and returns the resulting row.
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
  /// The returned [CoachNote] will have its `id` field set.
  Future<CoachNote?> upsertRow(
    _is.DatabaseSession session,
    CoachNote row, {
    required _is.ColumnSelections<CoachNoteTable> conflictColumns,
    _is.ColumnSelections<CoachNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<CoachNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CoachNote>(
      row,
      conflictColumns: conflictColumns(CoachNote.t),
      updateColumns: updateColumns?.call(CoachNote.t),
      updateWhere: updateWhere?.call(CoachNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [CoachNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachNote>> update(
    _is.DatabaseSession session,
    List<CoachNote> rows, {
    _is.ColumnSelections<CoachNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CoachNote>(
      rows,
      columns: columns?.call(CoachNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CoachNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CoachNote> updateRow(
    _is.DatabaseSession session,
    CoachNote row, {
    _is.ColumnSelections<CoachNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CoachNote>(
      row,
      columns: columns?.call(CoachNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CoachNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CoachNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CoachNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CoachNote>(
      id,
      columnValues: columnValues(CoachNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CoachNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CoachNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CoachNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CoachNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CoachNote>(
      columnValues: columnValues(CoachNote.t.updateTable),
      where: where(CoachNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CoachNote]s in the list and returns the deleted rows.
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
  Future<List<CoachNote>> delete(
    _is.DatabaseSession session,
    List<CoachNote> rows, {
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CoachNote>(
      rows,
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CoachNote].
  Future<CoachNote> deleteRow(
    _is.DatabaseSession session,
    CoachNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CoachNote>(
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
  Future<List<CoachNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CoachNoteTable> where,
    _is.OrderByBuilder<CoachNoteTable>? orderBy,
    _is.OrderByListBuilder<CoachNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CoachNote>(
      where: where(CoachNote.t),
      orderBy: orderBy?.call(CoachNote.t),
      orderByList: orderByList?.call(CoachNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CoachNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CoachNote>(
      where: where?.call(CoachNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CoachNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CoachNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CoachNote>(
      where: where(CoachNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
