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
import '../coach/coach_note.dart' as _iy0ledlp;

/// A read-only link that lets a coach see a user's progress and leave notes.
abstract class CoachShare
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CoachShare._({
    this.id,
    required this.authUserId,
    required this.code,
    required this.label,
    DateTime? createdAt,
    this.revokedAt,
    int? viewCount,
    this.lastViewedAt,
    this.notes,
  }) : createdAt = createdAt ?? DateTime.now(),
       viewCount = viewCount ?? 0;

  factory CoachShare({
    int? id,
    required _isc.UuidValue authUserId,
    required String code,
    required String label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  }) = _CoachShareImpl;

  factory CoachShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachShare(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      code: jsonSerialization['code'] as String,
      label: jsonSerialization['label'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      viewCount: jsonSerialization['viewCount'] as int?,
      lastViewedAt: jsonSerialization['lastViewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastViewedAt'],
            ),
      notes: jsonSerialization['notes'] == null
          ? null
          : _iiax327e.Protocol().deserialize<List<_iy0ledlp.CoachNote>>(
              jsonSerialization['notes'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Owner of the shared progress (Serverpod auth user id).
  _isc.UuidValue authUserId;

  /// Random, unguessable code used in the share link.
  String code;

  /// Who the link is for, e.g. "Coach Priya".
  String label;

  DateTime createdAt;

  DateTime? revokedAt;

  int viewCount;

  DateTime? lastViewedAt;

  List<_iy0ledlp.CoachNote>? notes;

  /// Returns a shallow copy of this [CoachShare]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CoachShare copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? code,
    String? label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'label': label,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'label': label,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'viewCount': viewCount,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      if (notes != null)
        'notes': notes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachShareImpl extends CoachShare {
  _CoachShareImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String code,
    required String label,
    DateTime? createdAt,
    DateTime? revokedAt,
    int? viewCount,
    DateTime? lastViewedAt,
    List<_iy0ledlp.CoachNote>? notes,
  }) : super._(
         id: id,
         authUserId: authUserId,
         code: code,
         label: label,
         createdAt: createdAt,
         revokedAt: revokedAt,
         viewCount: viewCount,
         lastViewedAt: lastViewedAt,
         notes: notes,
       );

  /// Returns a shallow copy of this [CoachShare]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CoachShare copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? code,
    String? label,
    DateTime? createdAt,
    Object? revokedAt = _Undefined,
    int? viewCount,
    Object? lastViewedAt = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CoachShare(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      code: code ?? this.code,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      viewCount: viewCount ?? this.viewCount,
      lastViewedAt: lastViewedAt is DateTime?
          ? lastViewedAt
          : this.lastViewedAt,
      notes: notes is List<_iy0ledlp.CoachNote>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
