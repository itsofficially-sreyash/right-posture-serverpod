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

/// Feedback a coach left through a share link.
abstract class CoachNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CoachNote._({
    this.id,
    required this.shareId,
    required this.authorName,
    required this.message,
    DateTime? createdAt,
    this.readAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CoachNote({
    int? id,
    required int shareId,
    required String authorName,
    required String message,
    DateTime? createdAt,
    DateTime? readAt,
  }) = _CoachNoteImpl;

  factory CoachNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachNote(
      id: jsonSerialization['id'] as int?,
      shareId: jsonSerialization['shareId'] as int,
      authorName: jsonSerialization['authorName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shareId;

  String authorName;

  String message;

  DateTime createdAt;

  DateTime? readAt;

  /// Returns a shallow copy of this [CoachNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CoachNote copyWith({
    int? id,
    int? shareId,
    String? authorName,
    String? message,
    DateTime? createdAt,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachNote',
      if (id != null) 'id': id,
      'shareId': shareId,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachNote',
      if (id != null) 'id': id,
      'shareId': shareId,
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachNoteImpl extends CoachNote {
  _CoachNoteImpl({
    int? id,
    required int shareId,
    required String authorName,
    required String message,
    DateTime? createdAt,
    DateTime? readAt,
  }) : super._(
         id: id,
         shareId: shareId,
         authorName: authorName,
         message: message,
         createdAt: createdAt,
         readAt: readAt,
       );

  /// Returns a shallow copy of this [CoachNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CoachNote copyWith({
    Object? id = _Undefined,
    int? shareId,
    String? authorName,
    String? message,
    DateTime? createdAt,
    Object? readAt = _Undefined,
  }) {
    return CoachNote(
      id: id is int? ? id : this.id,
      shareId: shareId ?? this.shareId,
      authorName: authorName ?? this.authorName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt is DateTime? ? readAt : this.readAt,
    );
  }
}
