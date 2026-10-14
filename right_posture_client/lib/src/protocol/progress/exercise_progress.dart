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

/// Progress for one exercise.
abstract class ExerciseProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExerciseProgress._({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.goodReps,
    required this.warningReps,
    required this.degradedReps,
    this.averageFormScore,
    this.bestFormScore,
    required this.weeklySets,
    required this.weeklyReps,
    this.weeklyFormScore,
    this.topIssue,
    required this.topIssueCount,
    required this.insights,
  });

  factory ExerciseProgress({
    required String exercise,
    required int sets,
    required int reps,
    required int goodReps,
    required int warningReps,
    required int degradedReps,
    double? averageFormScore,
    double? bestFormScore,
    required int weeklySets,
    required int weeklyReps,
    double? weeklyFormScore,
    String? topIssue,
    required int topIssueCount,
    required List<String> insights,
  }) = _ExerciseProgressImpl;

  factory ExerciseProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExerciseProgress(
      exercise: jsonSerialization['exercise'] as String,
      sets: jsonSerialization['sets'] as int,
      reps: jsonSerialization['reps'] as int,
      goodReps: jsonSerialization['goodReps'] as int,
      warningReps: jsonSerialization['warningReps'] as int,
      degradedReps: jsonSerialization['degradedReps'] as int,
      averageFormScore: (jsonSerialization['averageFormScore'] as num?)
          ?.toDouble(),
      bestFormScore: (jsonSerialization['bestFormScore'] as num?)?.toDouble(),
      weeklySets: jsonSerialization['weeklySets'] as int,
      weeklyReps: jsonSerialization['weeklyReps'] as int,
      weeklyFormScore: (jsonSerialization['weeklyFormScore'] as num?)
          ?.toDouble(),
      topIssue: jsonSerialization['topIssue'] as String?,
      topIssueCount: jsonSerialization['topIssueCount'] as int,
      insights: _iiax327e.Protocol().deserialize<List<String>>(
        jsonSerialization['insights'],
      ),
    );
  }

  /// `ExerciseId` name from the core engine, e.g. `squat`.
  String exercise;

  int sets;

  int reps;

  int goodReps;

  int warningReps;

  int degradedReps;

  double? averageFormScore;

  double? bestFormScore;

  int weeklySets;

  int weeklyReps;

  double? weeklyFormScore;

  /// Most frequent recorded issue metric, if any.
  String? topIssue;

  int topIssueCount;

  /// Evidence-linked, plain-language insights.
  List<String> insights;

  /// Returns a shallow copy of this [ExerciseProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExerciseProgress copyWith({
    String? exercise,
    int? sets,
    int? reps,
    int? goodReps,
    int? warningReps,
    int? degradedReps,
    double? averageFormScore,
    double? bestFormScore,
    int? weeklySets,
    int? weeklyReps,
    double? weeklyFormScore,
    String? topIssue,
    int? topIssueCount,
    List<String>? insights,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExerciseProgress',
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'goodReps': goodReps,
      'warningReps': warningReps,
      'degradedReps': degradedReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      if (bestFormScore != null) 'bestFormScore': bestFormScore,
      'weeklySets': weeklySets,
      'weeklyReps': weeklyReps,
      if (weeklyFormScore != null) 'weeklyFormScore': weeklyFormScore,
      if (topIssue != null) 'topIssue': topIssue,
      'topIssueCount': topIssueCount,
      'insights': insights.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExerciseProgress',
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'goodReps': goodReps,
      'warningReps': warningReps,
      'degradedReps': degradedReps,
      if (averageFormScore != null) 'averageFormScore': averageFormScore,
      if (bestFormScore != null) 'bestFormScore': bestFormScore,
      'weeklySets': weeklySets,
      'weeklyReps': weeklyReps,
      if (weeklyFormScore != null) 'weeklyFormScore': weeklyFormScore,
      if (topIssue != null) 'topIssue': topIssue,
      'topIssueCount': topIssueCount,
      'insights': insights.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExerciseProgressImpl extends ExerciseProgress {
  _ExerciseProgressImpl({
    required String exercise,
    required int sets,
    required int reps,
    required int goodReps,
    required int warningReps,
    required int degradedReps,
    double? averageFormScore,
    double? bestFormScore,
    required int weeklySets,
    required int weeklyReps,
    double? weeklyFormScore,
    String? topIssue,
    required int topIssueCount,
    required List<String> insights,
  }) : super._(
         exercise: exercise,
         sets: sets,
         reps: reps,
         goodReps: goodReps,
         warningReps: warningReps,
         degradedReps: degradedReps,
         averageFormScore: averageFormScore,
         bestFormScore: bestFormScore,
         weeklySets: weeklySets,
         weeklyReps: weeklyReps,
         weeklyFormScore: weeklyFormScore,
         topIssue: topIssue,
         topIssueCount: topIssueCount,
         insights: insights,
       );

  /// Returns a shallow copy of this [ExerciseProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExerciseProgress copyWith({
    String? exercise,
    int? sets,
    int? reps,
    int? goodReps,
    int? warningReps,
    int? degradedReps,
    Object? averageFormScore = _Undefined,
    Object? bestFormScore = _Undefined,
    int? weeklySets,
    int? weeklyReps,
    Object? weeklyFormScore = _Undefined,
    Object? topIssue = _Undefined,
    int? topIssueCount,
    List<String>? insights,
  }) {
    return ExerciseProgress(
      exercise: exercise ?? this.exercise,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      goodReps: goodReps ?? this.goodReps,
      warningReps: warningReps ?? this.warningReps,
      degradedReps: degradedReps ?? this.degradedReps,
      averageFormScore: averageFormScore is double?
          ? averageFormScore
          : this.averageFormScore,
      bestFormScore: bestFormScore is double?
          ? bestFormScore
          : this.bestFormScore,
      weeklySets: weeklySets ?? this.weeklySets,
      weeklyReps: weeklyReps ?? this.weeklyReps,
      weeklyFormScore: weeklyFormScore is double?
          ? weeklyFormScore
          : this.weeklyFormScore,
      topIssue: topIssue is String? ? topIssue : this.topIssue,
      topIssueCount: topIssueCount ?? this.topIssueCount,
      insights: insights ?? this.insights.map((e0) => e0).toList(),
    );
  }
}
