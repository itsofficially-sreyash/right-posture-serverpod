import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'coach_service.dart';

/// Athlete side of coach sharing: manage share links and read coach notes.
class CoachEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a share link for a coach named [label].
  Future<CoachShareInfo> createShare(Session session, String label) async {
    final userId = session.authenticated!.authUserId;
    final name = label.trim();
    if (name.isEmpty || name.length > CoachService.maxLabelLength) {
      throw ArgumentError.value(label, 'label', 'Invalid physio name');
    }
    final active = await CoachShare.db.count(
      session,
      where: (t) => t.authUserId.equals(userId) & t.revokedAt.equals(null),
    );
    if (active >= CoachService.maxActiveShares) {
      throw StateError('Revoke a link before creating another one');
    }
    for (var attempt = 0; ; attempt++) {
      try {
        final share = await CoachShare.db.insertRow(
          session,
          CoachShare(
            authUserId: userId,
            code: CoachService.newCode(),
            label: name,
          ),
        );
        return _info(session, share, noteCount: 0, unread: 0);
      } on DatabaseException {
        // A code collision is astronomically unlikely; retry a few times.
        if (attempt >= 3) rethrow;
      }
    }
  }

  /// The user's active share links, newest first.
  Future<List<CoachShareInfo>> listShares(Session session) async {
    final userId = session.authenticated!.authUserId;
    final shares = await CoachShare.db.find(
      session,
      where: (t) => t.authUserId.equals(userId) & t.revokedAt.equals(null),
      orderBy: (t) => t.createdAt.desc(),
      include: CoachShare.include(notes: CoachNote.includeList()),
    );
    return [
      for (final share in shares)
        _info(
          session,
          share,
          noteCount: share.notes?.length ?? 0,
          unread: share.notes?.where((n) => n.readAt == null).length ?? 0,
        ),
    ];
  }

  /// Stops a share link from working. Notes stay readable in the app.
  Future<bool> revokeShare(Session session, String code) async {
    final userId = session.authenticated!.authUserId;
    final share = await CoachShare.db.findFirstRow(
      session,
      where: (t) =>
          t.authUserId.equals(userId) &
          t.code.equals(CoachService.normalizeCode(code)) &
          t.revokedAt.equals(null),
    );
    if (share == null) return false;
    await CoachShare.db.updateRow(
      session,
      share.copyWith(revokedAt: DateTime.now().toUtc()),
    );
    return true;
  }

  /// Notes coaches left on any of the user's links, newest first.
  Future<List<CoachNoteInfo>> notes(Session session) async {
    final userId = session.authenticated!.authUserId;
    final shares = await CoachShare.db.find(
      session,
      where: (t) => t.authUserId.equals(userId),
      include: CoachShare.include(
        notes: CoachNote.includeList(orderBy: (t) => t.createdAt.desc()),
      ),
    );
    final result = [
      for (final share in shares)
        for (final note in share.notes ?? const <CoachNote>[])
          CoachNoteInfo(
            id: note.id!,
            shareLabel: share.label,
            authorName: note.authorName,
            message: note.message,
            createdAt: note.createdAt,
            read: note.readAt != null,
          ),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return result;
  }

  /// Marks every note on the user's links as read. Returns how many changed.
  Future<int> markNotesRead(Session session) async {
    final userId = session.authenticated!.authUserId;
    final shares = await CoachShare.db.find(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    if (shares.isEmpty) return 0;
    final ids = shares.map((s) => s.id!).toSet();
    final unread = await CoachNote.db.find(
      session,
      where: (t) => t.shareId.inSet(ids) & t.readAt.equals(null),
    );
    if (unread.isEmpty) return 0;
    final now = DateTime.now().toUtc();
    await CoachNote.db.update(session, [
      for (final note in unread) note.copyWith(readAt: now),
    ]);
    return unread.length;
  }

  CoachShareInfo _info(
    Session session,
    CoachShare share, {
    required int noteCount,
    required int unread,
  }) => CoachShareInfo(
    code: share.code,
    label: share.label,
    url: CoachService.shareUrl(session, share.code),
    createdAt: share.createdAt,
    viewCount: share.viewCount,
    lastViewedAt: share.lastViewedAt,
    noteCount: noteCount,
    unreadNoteCount: unread,
  );
}

/// Coach side: open a share code in the app and leave feedback. No account
/// needed; the unguessable code is the credential.
class CoachViewEndpoint extends Endpoint {
  /// Progress shared through [code], or null if the link is unknown or revoked.
  Future<SharedProgress?> view(
    Session session,
    String code,
    int utcOffsetMinutes,
  ) async {
    final share = await CoachService.findActive(session, code);
    if (share == null) return null;
    return CoachService.sharedProgress(
      session,
      share,
      utcOffsetMinutes: utcOffsetMinutes,
    );
  }

  /// Leaves a note for the athlete. Returns false if the link is not active.
  Future<bool> leaveNote(
    Session session,
    String code,
    String authorName,
    String message,
  ) async {
    final share = await CoachService.findActive(session, code);
    if (share == null) return false;
    return CoachService.addNote(
      session,
      share,
      authorName: authorName,
      message: message,
    );
  }
}
