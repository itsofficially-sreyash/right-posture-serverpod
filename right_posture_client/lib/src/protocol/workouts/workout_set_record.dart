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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// One exercise set inside a synced workout.
abstract class WorkoutSetRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue authUserId,
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
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      exercise: jsonSerialization['exercise'] as String,
      completedAt: _isc.DateTimeJsonExtension.fromJson(
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workoutId;

  _isc.UuidValue authUserId;

  String exercise;

  DateTime completedAt;

  int totalReps;

  int goodReps;

  int warningReps;

  int degradedReps;

  double? formScore;

  double? consistencyScore;

  int? degradationStartRep;

  /// Returns a shallow copy of this [WorkoutSetRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutSetRecord copyWith({
    int? id,
    int? workoutId,
    _isc.UuidValue? authUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSetRecordImpl extends WorkoutSetRecord {
  _WorkoutSetRecordImpl({
    int? id,
    required int workoutId,
    required _isc.UuidValue authUserId,
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
  @_isc.useResult
  @override
  WorkoutSetRecord copyWith({
    Object? id = _Undefined,
    int? workoutId,
    _isc.UuidValue? authUserId,
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
