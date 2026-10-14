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
import 'package:right_posture_server/src/generated/protocol.dart' as _id3zg6f1;
import 'package:serverpod/serverpod.dart' as _is;
import '../progress/exercise_progress.dart' as _ie7bmn18;

/// Cross-workout progress computed on the server with the shared core engine.
abstract class ProgressReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProgressReport._({
    required this.generatedAt,
    required this.workoutCount,
    required this.setCount,
    required this.totalReps,
    required this.streakDays,
    required this.activeDaysLast28,
    required this.exercises,
  });

  factory ProgressReport({
    required DateTime generatedAt,
    required int workoutCount,
    required int setCount,
    required int totalReps,
    required int streakDays,
    required int activeDaysLast28,
    required List<_ie7bmn18.ExerciseProgress> exercises,
  }) = _ProgressReportImpl;

  factory ProgressReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressReport(
      generatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      workoutCount: jsonSerialization['workoutCount'] as int,
      setCount: jsonSerialization['setCount'] as int,
      totalReps: jsonSerialization['totalReps'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      activeDaysLast28: jsonSerialization['activeDaysLast28'] as int,
      exercises: _id3zg6f1.Protocol()
          .deserialize<List<_ie7bmn18.ExerciseProgress>>(
            jsonSerialization['exercises'],
          ),
    );
  }

  DateTime generatedAt;

  int workoutCount;

  int setCount;

  int totalReps;

  /// Consecutive local days (ending today or yesterday) with a workout.
  int streakDays;

  int activeDaysLast28;

  List<_ie7bmn18.ExerciseProgress> exercises;

  /// Returns a shallow copy of this [ProgressReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProgressReport copyWith({
    DateTime? generatedAt,
    int? workoutCount,
    int? setCount,
    int? totalReps,
    int? streakDays,
    int? activeDaysLast28,
    List<_ie7bmn18.ExerciseProgress>? exercises,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressReport',
      'generatedAt': generatedAt.toJson(),
      'workoutCount': workoutCount,
      'setCount': setCount,
      'totalReps': totalReps,
      'streakDays': streakDays,
      'activeDaysLast28': activeDaysLast28,
      'exercises': exercises.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProgressReport',
      'generatedAt': generatedAt.toJson(),
      'workoutCount': workoutCount,
      'setCount': setCount,
      'totalReps': totalReps,
      'streakDays': streakDays,
      'activeDaysLast28': activeDaysLast28,
      'exercises': exercises.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ProgressReportImpl extends ProgressReport {
  _ProgressReportImpl({
    required DateTime generatedAt,
    required int workoutCount,
    required int setCount,
    required int totalReps,
    required int streakDays,
    required int activeDaysLast28,
    required List<_ie7bmn18.ExerciseProgress> exercises,
  }) : super._(
         generatedAt: generatedAt,
         workoutCount: workoutCount,
         setCount: setCount,
         totalReps: totalReps,
         streakDays: streakDays,
         activeDaysLast28: activeDaysLast28,
         exercises: exercises,
       );

  /// Returns a shallow copy of this [ProgressReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProgressReport copyWith({
    DateTime? generatedAt,
    int? workoutCount,
    int? setCount,
    int? totalReps,
    int? streakDays,
    int? activeDaysLast28,
    List<_ie7bmn18.ExerciseProgress>? exercises,
  }) {
    return ProgressReport(
      generatedAt: generatedAt ?? this.generatedAt,
      workoutCount: workoutCount ?? this.workoutCount,
      setCount: setCount ?? this.setCount,
      totalReps: totalReps ?? this.totalReps,
      streakDays: streakDays ?? this.streakDays,
      activeDaysLast28: activeDaysLast28 ?? this.activeDaysLast28,
      exercises:
          exercises ?? this.exercises.map((e0) => e0.copyWith()).toList(),
    );
  }
}
