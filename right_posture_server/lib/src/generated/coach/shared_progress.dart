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
import '../coach/shared_note.dart' as _ihgeaifa;
import '../coach/shared_workout.dart' as _ign42q58;
import '../progress/progress_report.dart' as _inkcg3o5;

/// What a coach sees through a share link.
abstract class SharedProgress
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SharedProgress._({
    required this.label,
    required this.report,
    required this.recentWorkouts,
    required this.notes,
  });

  factory SharedProgress({
    required String label,
    required _inkcg3o5.ProgressReport report,
    required List<_ign42q58.SharedWorkout> recentWorkouts,
    required List<_ihgeaifa.SharedNote> notes,
  }) = _SharedProgressImpl;

  factory SharedProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return SharedProgress(
      label: jsonSerialization['label'] as String,
      report: _id3zg6f1.Protocol().deserialize<_inkcg3o5.ProgressReport>(
        jsonSerialization['report'],
      ),
      recentWorkouts: _id3zg6f1.Protocol()
          .deserialize<List<_ign42q58.SharedWorkout>>(
            jsonSerialization['recentWorkouts'],
          ),
      notes: _id3zg6f1.Protocol().deserialize<List<_ihgeaifa.SharedNote>>(
        jsonSerialization['notes'],
      ),
    );
  }

  /// The label the athlete gave this link.
  String label;

  _inkcg3o5.ProgressReport report;

  List<_ign42q58.SharedWorkout> recentWorkouts;

  List<_ihgeaifa.SharedNote> notes;

  /// Returns a shallow copy of this [SharedProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SharedProgress copyWith({
    String? label,
    _inkcg3o5.ProgressReport? report,
    List<_ign42q58.SharedWorkout>? recentWorkouts,
    List<_ihgeaifa.SharedNote>? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SharedProgress',
      'label': label,
      'report': report.toJson(),
      'recentWorkouts': recentWorkouts.toJson(valueToJson: (v) => v.toJson()),
      'notes': notes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SharedProgress',
      'label': label,
      'report': report.toJsonForProtocol(),
      'recentWorkouts': recentWorkouts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'notes': notes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SharedProgressImpl extends SharedProgress {
  _SharedProgressImpl({
    required String label,
    required _inkcg3o5.ProgressReport report,
    required List<_ign42q58.SharedWorkout> recentWorkouts,
    required List<_ihgeaifa.SharedNote> notes,
  }) : super._(
         label: label,
         report: report,
         recentWorkouts: recentWorkouts,
         notes: notes,
       );

  /// Returns a shallow copy of this [SharedProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SharedProgress copyWith({
    String? label,
    _inkcg3o5.ProgressReport? report,
    List<_ign42q58.SharedWorkout>? recentWorkouts,
    List<_ihgeaifa.SharedNote>? notes,
  }) {
    return SharedProgress(
      label: label ?? this.label,
      report: report ?? this.report.copyWith(),
      recentWorkouts:
          recentWorkouts ??
          this.recentWorkouts.map((e0) => e0.copyWith()).toList(),
      notes: notes ?? this.notes.map((e0) => e0.copyWith()).toList(),
    );
  }
}
