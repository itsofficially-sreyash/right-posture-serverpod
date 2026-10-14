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
import 'package:right_posture_client/src/protocol/protocol.dart' as _iiax327e;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../workouts/workout_set_record.dart' as _i2xuzwpe;

/// A finished workout synced from a user's phone. Only bounded summary
/// evidence is stored; camera frames and pose landmarks never leave the device.
abstract class WorkoutRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue authUserId,
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
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      clientId: jsonSerialization['clientId'] as String,
      completedAt: _isc.DateTimeJsonExtension.fromJson(
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
          : _iiax327e.Protocol().deserialize<List<_i2xuzwpe.WorkoutSetRecord>>(
              jsonSerialization['sets'],
            ),
      uploadedAt: jsonSerialization['uploadedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['uploadedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Owner of the workout (Serverpod auth user id).
  _isc.UuidValue authUserId;

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

  /// Returns a shallow copy of this [WorkoutRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkoutRecord copyWith({
    int? id,
    _isc.UuidValue? authUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutRecordImpl extends WorkoutRecord {
  _WorkoutRecordImpl({
    int? id,
    required _isc.UuidValue authUserId,
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
  @_isc.useResult
  @override
  WorkoutRecord copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
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
