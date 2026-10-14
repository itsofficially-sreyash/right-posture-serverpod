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
import 'package:right_posture_client/src/protocol/workouts/synced_workout.dart'
    as _i7y060ko;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'progress/exercise_progress.dart' as _ixpsjq05;
import 'progress/progress_report.dart' as _i5135299;
import 'workouts/sync_status.dart' as _ibnhdbpa;
import 'workouts/synced_workout.dart' as _iqbxod9e;
import 'workouts/workout_record.dart' as _icm4262y;
import 'workouts/workout_set_record.dart' as _i128p1vq;
export 'progress/exercise_progress.dart';
export 'progress/progress_report.dart';
export 'workouts/sync_status.dart';
export 'workouts/synced_workout.dart';
export 'workouts/workout_record.dart';
export 'workouts/workout_set_record.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
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
    if (t == _isc.getType<_ixpsjq05.ExerciseProgress?>()) {
      return (data != null ? _ixpsjq05.ExerciseProgress.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5135299.ProgressReport?>()) {
      return (data != null ? _i5135299.ProgressReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibnhdbpa.SyncStatus?>()) {
      return (data != null ? _ibnhdbpa.SyncStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqbxod9e.SyncedWorkout?>()) {
      return (data != null ? _iqbxod9e.SyncedWorkout.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icm4262y.WorkoutRecord?>()) {
      return (data != null ? _icm4262y.WorkoutRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i128p1vq.WorkoutSetRecord?>()) {
      return (data != null ? _i128p1vq.WorkoutSetRecord.fromJson(data) : null)
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
    if (t == _isc.getType<List<_i128p1vq.WorkoutSetRecord>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i128p1vq.WorkoutSetRecord>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i7y060ko.SyncedWorkout>) {
      return (data as List)
              .map((e) => deserialize<_i7y060ko.SyncedWorkout>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('right_posture', this);
    _iacc.Protocol().registerHostProtocol('right_posture', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
