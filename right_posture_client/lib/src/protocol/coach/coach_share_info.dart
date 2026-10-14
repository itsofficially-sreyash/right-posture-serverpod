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

/// A share link as shown to its owner.
abstract class CoachShareInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CoachShareInfo._({
    required this.code,
    required this.label,
    required this.url,
    required this.createdAt,
    required this.viewCount,
    this.lastViewedAt,
    required this.noteCount,
    required this.unreadNoteCount,
  });

  factory CoachShareInfo({
    required String code,
    required String label,
    required String url,
    required DateTime createdAt,
    required int viewCount,
    DateTime? lastViewedAt,
    required int noteCount,
    required int unreadNoteCount,
  }) = _CoachShareInfoImpl;

  factory CoachShareInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachShareInfo(
      code: jsonSerialization['code'] as String,
      label: jsonSerialization['label'] as String,
      url: jsonSerialization['url'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      viewCount: jsonSerialization['viewCount'] as int,
      lastViewedAt: jsonSerialization['lastViewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastViewedAt'],
            ),
      noteCount: jsonSerialization['noteCount'] as int,
      unreadNoteCount: jsonSerialization['unreadNoteCount'] as int,
    );
  }

  String code;

  String label;

  String url;

  DateTime createdAt;

  int viewCount;

  DateTime? lastViewedAt;

  int noteCount;

  int unreadNoteCount;

  /// Returns a shallow copy of this [CoachShareInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CoachShareInfo copyWith({
    String? code,
    String? label,
    String? url,
    DateTime? createdAt,
    int? viewCount,
    DateTime? lastViewedAt,
    int? noteCount,
    int? unreadNoteCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachShareInfo',
      'code': code,
      'label': label,
      'url': url,
      'createdAt': createdAt.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      'noteCount': noteCount,
      'unreadNoteCount': unreadNoteCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachShareInfo',
      'code': code,
      'label': label,
      'url': url,
      'createdAt': createdAt.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      'noteCount': noteCount,
      'unreadNoteCount': unreadNoteCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachShareInfoImpl extends CoachShareInfo {
  _CoachShareInfoImpl({
    required String code,
    required String label,
    required String url,
    required DateTime createdAt,
    required int viewCount,
    DateTime? lastViewedAt,
    required int noteCount,
    required int unreadNoteCount,
  }) : super._(
         code: code,
         label: label,
         url: url,
         createdAt: createdAt,
         viewCount: viewCount,
         lastViewedAt: lastViewedAt,
         noteCount: noteCount,
         unreadNoteCount: unreadNoteCount,
       );

  /// Returns a shallow copy of this [CoachShareInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CoachShareInfo copyWith({
    String? code,
    String? label,
    String? url,
    DateTime? createdAt,
    int? viewCount,
    Object? lastViewedAt = _Undefined,
    int? noteCount,
    int? unreadNoteCount,
  }) {
    return CoachShareInfo(
      code: code ?? this.code,
      label: label ?? this.label,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      viewCount: viewCount ?? this.viewCount,
      lastViewedAt: lastViewedAt is DateTime?
          ? lastViewedAt
          : this.lastViewedAt,
      noteCount: noteCount ?? this.noteCount,
      unreadNoteCount: unreadNoteCount ?? this.unreadNoteCount,
    );
  }
}
