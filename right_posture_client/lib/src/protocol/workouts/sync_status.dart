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

/// Summary of the signed-in user's cloud backup.
abstract class SyncStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncStatus._({
    required this.workoutCount,
    required this.setCount,
    required this.totalReps,
    this.lastCompletedAt,
  });

  factory SyncStatus({
    required int workoutCount,
    required int setCount,
    required int totalReps,
    DateTime? lastCompletedAt,
  }) = _SyncStatusImpl;

  factory SyncStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncStatus(
      workoutCount: jsonSerialization['workoutCount'] as int,
      setCount: jsonSerialization['setCount'] as int,
      totalReps: jsonSerialization['totalReps'] as int,
      lastCompletedAt: jsonSerialization['lastCompletedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCompletedAt'],
            ),
    );
  }

  int workoutCount;

  int setCount;

  int totalReps;

  DateTime? lastCompletedAt;

  /// Returns a shallow copy of this [SyncStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncStatus copyWith({
    int? workoutCount,
    int? setCount,
    int? totalReps,
    DateTime? lastCompletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncStatus',
      'workoutCount': workoutCount,
      'setCount': setCount,
      'totalReps': totalReps,
      if (lastCompletedAt != null) 'lastCompletedAt': lastCompletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncStatus',
      'workoutCount': workoutCount,
      'setCount': setCount,
      'totalReps': totalReps,
      if (lastCompletedAt != null) 'lastCompletedAt': lastCompletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncStatusImpl extends SyncStatus {
  _SyncStatusImpl({
    required int workoutCount,
    required int setCount,
    required int totalReps,
    DateTime? lastCompletedAt,
  }) : super._(
         workoutCount: workoutCount,
         setCount: setCount,
         totalReps: totalReps,
         lastCompletedAt: lastCompletedAt,
       );

  /// Returns a shallow copy of this [SyncStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncStatus copyWith({
    int? workoutCount,
    int? setCount,
    int? totalReps,
    Object? lastCompletedAt = _Undefined,
  }) {
    return SyncStatus(
      workoutCount: workoutCount ?? this.workoutCount,
      setCount: setCount ?? this.setCount,
      totalReps: totalReps ?? this.totalReps,
      lastCompletedAt: lastCompletedAt is DateTime?
          ? lastCompletedAt
          : this.lastCompletedAt,
    );
  }
}
