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
import 'package:serverpod/serverpod.dart' as _is;

/// A coach note as shown to the athlete.
abstract class CoachNoteInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CoachNoteInfo._({
    required this.id,
    required this.shareLabel,
    required this.authorName,
    required this.message,
    required this.createdAt,
    required this.read,
  });

  factory CoachNoteInfo({
    required int id,
    required String shareLabel,
    required String authorName,
    required String message,
    required DateTime createdAt,
    required bool read,
  }) = _CoachNoteInfoImpl;

  factory CoachNoteInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachNoteInfo(
      id: jsonSerialization['id'] as int,
      shareLabel: jsonSerialization['shareLabel'] as String,
      authorName: jsonSerialization['authorName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      read: _is.BoolJsonExtension.fromJson(jsonSerialization['read']),
    );
  }

  int id;

  String shareLabel;

  String authorName;

  String message;

  DateTime createdAt;

  bool read;

  /// Returns a shallow copy of this [CoachNoteInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CoachNoteInfo copyWith({
    int? id,
    String? shareLabel,
    String? authorName,
    String? message,
    DateTime? createdAt,
    bool? read,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachNoteInfo',
      'id': id,
      'shareLabel': shareLabel,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      'read': read,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachNoteInfo',
      'id': id,
      'shareLabel': shareLabel,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      'read': read,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CoachNoteInfoImpl extends CoachNoteInfo {
  _CoachNoteInfoImpl({
    required int id,
    required String shareLabel,
    required String authorName,
    required String message,
    required DateTime createdAt,
    required bool read,
  }) : super._(
         id: id,
         shareLabel: shareLabel,
         authorName: authorName,
         message: message,
         createdAt: createdAt,
         read: read,
       );

  /// Returns a shallow copy of this [CoachNoteInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CoachNoteInfo copyWith({
    int? id,
    String? shareLabel,
    String? authorName,
    String? message,
    DateTime? createdAt,
    bool? read,
  }) {
    return CoachNoteInfo(
      id: id ?? this.id,
      shareLabel: shareLabel ?? this.shareLabel,
      authorName: authorName ?? this.authorName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      read: read ?? this.read,
    );
  }
}
