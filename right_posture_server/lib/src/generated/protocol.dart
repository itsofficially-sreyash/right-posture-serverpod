/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:right_posture_server/src/generated/coach/coach_note_info.dart'
    as _iyfe0fzo;
import 'package:right_posture_server/src/generated/coach/coach_share_info.dart'
    as _iyjlb0nz;
import 'package:right_posture_server/src/generated/workouts/synced_workout.dart'
    as _i1tsvs2d;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'coach/coach_note.dart' as _i27dye3b;
import 'coach/coach_note_info.dart' as _ip4miwti;
import 'coach/coach_share.dart' as _i8dr5z6y;
import 'coach/coach_share_info.dart' as _i8wjefyn;
import 'coach/shared_note.dart' as _if69a7gd;
import 'coach/shared_progress.dart' as _ircl8yoo;
import 'coach/shared_workout.dart' as _ih0q5mdl;
import 'progress/exercise_progress.dart' as _ixpsjq05;
import 'progress/progress_report.dart' as _i5135299;
import 'workouts/sync_status.dart' as _ibnhdbpa;
import 'workouts/synced_workout.dart' as _iqbxod9e;
import 'workouts/workout_record.dart' as _icm4262y;
import 'workouts/workout_set_record.dart' as _i128p1vq;
export 'coach/coach_note.dart';
export 'coach/coach_note_info.dart';
export 'coach/coach_share.dart';
export 'coach/coach_share_info.dart';
export 'coach/shared_note.dart';
export 'coach/shared_progress.dart';
export 'coach/shared_workout.dart';
export 'progress/exercise_progress.dart';
export 'progress/progress_report.dart';
export 'workouts/sync_status.dart';
export 'workouts/synced_workout.dart';
export 'workouts/workout_record.dart';
export 'workouts/workout_set_record.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'coach_note',
      dartName: 'CoachNote',
      schema: 'public',
      module: 'right_posture',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'shareId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'readAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'coach_note_fk_0',
          columns: ['shareId'],
          referenceTable: 'coach_share',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'coach_note_share_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shareId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'coach_share',
      dartName: 'CoachShare',
      schema: 'public',
      module: 'right_posture',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'revokedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'viewCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'lastViewedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'coach_share_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'coach_share_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_record',
      dartName: 'WorkoutRecord',
      schema: 'public',
      module: 'right_posture',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'clientId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'note',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'setCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'totalReps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'averageFormScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'payload',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'uploadedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_record_owner_client_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'workout_record_owner_completed_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'completedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_set_record',
      dartName: 'WorkoutSetRecord',
      schema: 'public',
      module: 'right_posture',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workoutId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'exercise',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'totalReps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'goodReps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'warningReps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'degradedReps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'formScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'consistencyScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'degradationStartRep',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_set_record_fk_0',
          columns: ['workoutId'],
          referenceTable: 'workout_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_set_record_owner_exercise_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exercise',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'completedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i27dye3b.CoachNote) {
      return _i27dye3b.CoachNote.fromJson(data) as T;
    }
    if (t == _ip4miwti.CoachNoteInfo) {
      return _ip4miwti.CoachNoteInfo.fromJson(data) as T;
    }
    if (t == _i8dr5z6y.CoachShare) {
      return _i8dr5z6y.CoachShare.fromJson(data) as T;
    }
    if (t == _i8wjefyn.CoachShareInfo) {
      return _i8wjefyn.CoachShareInfo.fromJson(data) as T;
    }
    if (t == _if69a7gd.SharedNote) {
      return _if69a7gd.SharedNote.fromJson(data) as T;
    }
    if (t == _ircl8yoo.SharedProgress) {
      return _ircl8yoo.SharedProgress.fromJson(data) as T;
    }
    if (t == _ih0q5mdl.SharedWorkout) {
      return _ih0q5mdl.SharedWorkout.fromJson(data) as T;
    }
    if (t == _ixpsjq05.ExerciseProgress) {
      return _ixpsjq05.ExerciseProgress.fromJson(data) as T;
    }
    if (t == _i5135299.ProgressReport) {
      return _i5135299.ProgressReport.fromJson(data) as T;
    }
    if (t == _ibnhdbpa.SyncStatus) {
      return _ibnhdbpa.SyncStatus.fromJson(data) as T;
    }
    if (t == _iqbxod9e.SyncedWorkout) {
      return _iqbxod9e.SyncedWorkout.fromJson(data) as T;
    }
    if (t == _icm4262y.WorkoutRecord) {
      return _icm4262y.WorkoutRecord.fromJson(data) as T;
    }
    if (t == _i128p1vq.WorkoutSetRecord) {
      return _i128p1vq.WorkoutSetRecord.fromJson(data) as T;
    }
    if (t == _is.getType<_i27dye3b.CoachNote?>()) {
      return (data != null ? _i27dye3b.CoachNote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ip4miwti.CoachNoteInfo?>()) {
      return (data != null ? _ip4miwti.CoachNoteInfo.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8dr5z6y.CoachShare?>()) {
      return (data != null ? _i8dr5z6y.CoachShare.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8wjefyn.CoachShareInfo?>()) {
      return (data != null ? _i8wjefyn.CoachShareInfo.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_if69a7gd.SharedNote?>()) {
      return (data != null ? _if69a7gd.SharedNote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ircl8yoo.SharedProgress?>()) {
      return (data != null ? _ircl8yoo.SharedProgress.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ih0q5mdl.SharedWorkout?>()) {
      return (data != null ? _ih0q5mdl.SharedWorkout.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixpsjq05.ExerciseProgress?>()) {
      return (data != null ? _ixpsjq05.ExerciseProgress.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5135299.ProgressReport?>()) {
      return (data != null ? _i5135299.ProgressReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibnhdbpa.SyncStatus?>()) {
      return (data != null ? _ibnhdbpa.SyncStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqbxod9e.SyncedWorkout?>()) {
      return (data != null ? _iqbxod9e.SyncedWorkout.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icm4262y.WorkoutRecord?>()) {
      return (data != null ? _icm4262y.WorkoutRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i128p1vq.WorkoutSetRecord?>()) {
      return (data != null ? _i128p1vq.WorkoutSetRecord.fromJson(data) : null)
          as T;
    }
    if (t == List<_i27dye3b.CoachNote>) {
      return (data as List)
              .map((e) => deserialize<_i27dye3b.CoachNote>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i27dye3b.CoachNote>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i27dye3b.CoachNote>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ih0q5mdl.SharedWorkout>) {
      return (data as List)
              .map((e) => deserialize<_ih0q5mdl.SharedWorkout>(e))
              .toList()
          as T;
    }
    if (t == List<_if69a7gd.SharedNote>) {
      return (data as List)
              .map((e) => deserialize<_if69a7gd.SharedNote>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ixpsjq05.ExerciseProgress>) {
      return (data as List)
              .map((e) => deserialize<_ixpsjq05.ExerciseProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i128p1vq.WorkoutSetRecord>) {
      return (data as List)
              .map((e) => deserialize<_i128p1vq.WorkoutSetRecord>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i128p1vq.WorkoutSetRecord>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i128p1vq.WorkoutSetRecord>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iyjlb0nz.CoachShareInfo>) {
      return (data as List)
              .map((e) => deserialize<_iyjlb0nz.CoachShareInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_iyfe0fzo.CoachNoteInfo>) {
      return (data as List)
              .map((e) => deserialize<_iyfe0fzo.CoachNoteInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_i1tsvs2d.SyncedWorkout>) {
      return (data as List)
              .map((e) => deserialize<_i1tsvs2d.SyncedWorkout>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i27dye3b.CoachNote => 'CoachNote',
      _ip4miwti.CoachNoteInfo => 'CoachNoteInfo',
      _i8dr5z6y.CoachShare => 'CoachShare',
      _i8wjefyn.CoachShareInfo => 'CoachShareInfo',
      _if69a7gd.SharedNote => 'SharedNote',
      _ircl8yoo.SharedProgress => 'SharedProgress',
      _ih0q5mdl.SharedWorkout => 'SharedWorkout',
      _ixpsjq05.ExerciseProgress => 'ExerciseProgress',
      _i5135299.ProgressReport => 'ProgressReport',
      _ibnhdbpa.SyncStatus => 'SyncStatus',
      _iqbxod9e.SyncedWorkout => 'SyncedWorkout',
      _icm4262y.WorkoutRecord => 'WorkoutRecord',
      _i128p1vq.WorkoutSetRecord => 'WorkoutSetRecord',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'right_posture.',
        '',
      );
    }

    switch (data) {
      case _i27dye3b.CoachNote():
        return 'CoachNote';
      case _ip4miwti.CoachNoteInfo():
        return 'CoachNoteInfo';
      case _i8dr5z6y.CoachShare():
        return 'CoachShare';
      case _i8wjefyn.CoachShareInfo():
        return 'CoachShareInfo';
      case _if69a7gd.SharedNote():
        return 'SharedNote';
      case _ircl8yoo.SharedProgress():
        return 'SharedProgress';
      case _ih0q5mdl.SharedWorkout():
        return 'SharedWorkout';
      case _ixpsjq05.ExerciseProgress():
        return 'ExerciseProgress';
      case _i5135299.ProgressReport():
        return 'ProgressReport';
      case _ibnhdbpa.SyncStatus():
        return 'SyncStatus';
      case _iqbxod9e.SyncedWorkout():
        return 'SyncedWorkout';
      case _icm4262y.WorkoutRecord():
        return 'WorkoutRecord';
      case _i128p1vq.WorkoutSetRecord():
        return 'WorkoutSetRecord';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CoachNote') {
      return deserialize<_i27dye3b.CoachNote>(data['data']);
    }
    if (dataClassName == 'CoachNoteInfo') {
      return deserialize<_ip4miwti.CoachNoteInfo>(data['data']);
    }
    if (dataClassName == 'CoachShare') {
      return deserialize<_i8dr5z6y.CoachShare>(data['data']);
    }
    if (dataClassName == 'CoachShareInfo') {
      return deserialize<_i8wjefyn.CoachShareInfo>(data['data']);
    }
    if (dataClassName == 'SharedNote') {
      return deserialize<_if69a7gd.SharedNote>(data['data']);
    }
    if (dataClassName == 'SharedProgress') {
      return deserialize<_ircl8yoo.SharedProgress>(data['data']);
    }
    if (dataClassName == 'SharedWorkout') {
      return deserialize<_ih0q5mdl.SharedWorkout>(data['data']);
    }
    if (dataClassName == 'ExerciseProgress') {
      return deserialize<_ixpsjq05.ExerciseProgress>(data['data']);
    }
    if (dataClassName == 'ProgressReport') {
      return deserialize<_i5135299.ProgressReport>(data['data']);
    }
    if (dataClassName == 'SyncStatus') {
      return deserialize<_ibnhdbpa.SyncStatus>(data['data']);
    }
    if (dataClassName == 'SyncedWorkout') {
      return deserialize<_iqbxod9e.SyncedWorkout>(data['data']);
    }
    if (dataClassName == 'WorkoutRecord') {
      return deserialize<_icm4262y.WorkoutRecord>(data['data']);
    }
    if (dataClassName == 'WorkoutSetRecord') {
      return deserialize<_i128p1vq.WorkoutSetRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('right_posture', this);
    _iacs.Protocol().registerHostProtocol('right_posture', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i27dye3b.CoachNote:
        return _i27dye3b.CoachNote.t;
      case _i8dr5z6y.CoachShare:
        return _i8dr5z6y.CoachShare.t;
      case _icm4262y.WorkoutRecord:
        return _icm4262y.WorkoutRecord.t;
      case _i128p1vq.WorkoutSetRecord:
        return _i128p1vq.WorkoutSetRecord.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'right_posture';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
