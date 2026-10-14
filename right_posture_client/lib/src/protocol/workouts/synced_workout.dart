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

/// A workout returned to the app for restoring history on any device.
abstract class SyncedWorkout
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedWorkout._({
    required this.clientId,
    required this.payload,
  });

  factory SyncedWorkout({
    required String clientId,
    required String payload,
  }) = _SyncedWorkoutImpl;

  factory SyncedWorkout.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedWorkout(
      clientId: jsonSerialization['clientId'] as String,
      payload: jsonSerialization['payload'] as String,
    );
  }

  String clientId;

  String payload;

  /// Returns a shallow copy of this [SyncedWorkout]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedWorkout copyWith({
    String? clientId,
    String? payload,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedWorkout',
      'clientId': clientId,
      'payload': payload,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedWorkout',
      'clientId': clientId,
      'payload': payload,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SyncedWorkoutImpl extends SyncedWorkout {
  _SyncedWorkoutImpl({
    required String clientId,
    required String payload,
  }) : super._(
         clientId: clientId,
         payload: payload,
       );

  /// Returns a shallow copy of this [SyncedWorkout]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedWorkout copyWith({
    String? clientId,
    String? payload,
  }) {
    return SyncedWorkout(
      clientId: clientId ?? this.clientId,
      payload: payload ?? this.payload,
    );
  }
}
