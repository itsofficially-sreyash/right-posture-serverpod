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

/// A note visible on the shared page (to the coach who left it).
abstract class SharedNote
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SharedNote._({
    required this.authorName,
    required this.message,
    required this.createdAt,
  });

  factory SharedNote({
    required String authorName,
    required String message,
    required DateTime createdAt,
  }) = _SharedNoteImpl;

  factory SharedNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return SharedNote(
      authorName: jsonSerialization['authorName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String authorName;

  String message;

  DateTime createdAt;

  /// Returns a shallow copy of this [SharedNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SharedNote copyWith({
    String? authorName,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SharedNote',
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SharedNote',
      'authorName': authorName,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SharedNoteImpl extends SharedNote {
  _SharedNoteImpl({
    required String authorName,
    required String message,
    required DateTime createdAt,
  }) : super._(
         authorName: authorName,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SharedNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SharedNote copyWith({
    String? authorName,
    String? message,
    DateTime? createdAt,
  }) {
    return SharedNote(
      authorName: authorName ?? this.authorName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
