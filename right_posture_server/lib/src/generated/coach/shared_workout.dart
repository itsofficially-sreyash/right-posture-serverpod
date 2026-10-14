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

/// Summary of one workout as seen by a coach.
abstract class SharedWorkout
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SharedWorkout._({
    required this.completedAt,
    required this.exercises,
    required this.sets,
    required this.totalReps,
    this.averageFormScore,
    required this.degradedReps,
    this.note,
  });

  factory SharedWorkout({
    required DateTime completedAt,
    required List<String> exercises,
    required int sets,
    required int totalReps,
    double? averageFormScore,
    required int degradedReps,
    String? note,
  }) = _SharedWorkoutImpl;

  factory SharedWorkout.fromJson(Map<String, dynamic> jsonSerialization) {
    return SharedWorkout(
      completedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      exercises: _id3zg6f1.Protocol().deserialize<List<String>>(
        jsonSerialization['exercises'],
      ),
      sets: jsonSerialization['sets'] as int,
      totalReps: jsonSerialization['totalReps'] as int,
      averageFormScore: (jsonSerialization['averageFormScore'] as num?)
          ?.toDouble(),
      degradedReps: jsonSerialization['degradedReps'] as int,
      note: jsonSerialization['note'] as String?,
    );
  }

  DateTime completedAt;

  List<String> exercises;

  int sets;

  int totalReps;

  double? averageFormScore;

  int degradedReps;

  String? note;

  /// Returns a shallow copy of this [SharedWorkout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SharedWorkout copyWith({
    DateTime? completedAt,
    List<String>? exercises,
    int? sets,
    int? totalReps,
    double? averageFormScore,
    int? degradedReps,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SharedWorkout',
      'completedAt': completedAt.toJson(),
      'exercises': exercises.toJson(),
      'sets': sets,
      'totalReps': totalReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      'degradedReps': degradedReps,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SharedWorkout',
      'completedAt': completedAt.toJson(),
      'exercises': exercises.toJson(),
      'sets': sets,
      'totalReps': totalReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      'degradedReps': degradedReps,
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SharedWorkoutImpl extends SharedWorkout {
  _SharedWorkoutImpl({
    required DateTime completedAt,
    required List<String> exercises,
    required int sets,
    required int totalReps,
    double? averageFormScore,
    required int degradedReps,
    String? note,
  }) : super._(
         completedAt: completedAt,
         exercises: exercises,
         sets: sets,
         totalReps: totalReps,
         averageFormScore: averageFormScore,
         degradedReps: degradedReps,
         note: note,
       );

  /// Returns a shallow copy of this [SharedWorkout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SharedWorkout copyWith({
    DateTime? completedAt,
    List<String>? exercises,
    int? sets,
    int? totalReps,
    Object? averageFormScore = _Undefined,
    int? degradedReps,
    Object? note = _Undefined,
  }) {
    return SharedWorkout(
      completedAt: completedAt ?? this.completedAt,
      exercises: exercises ?? this.exercises.map((e0) => e0).toList(),
      sets: sets ?? this.sets,
      totalReps: totalReps ?? this.totalReps,
      averageFormScore: averageFormScore is double?
          ? averageFormScore
          : this.averageFormScore,
      degradedReps: degradedReps ?? this.degradedReps,
      note: note is String? ? note : this.note,
    );
  }
}
