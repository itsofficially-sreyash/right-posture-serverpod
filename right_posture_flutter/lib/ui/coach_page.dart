import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:right_posture_client/right_posture_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import 'app_theme.dart';
import 'auth_gate.dart';
import 'progress_report_view.dart';

/// Physio sharing: send your physiotherapist a live progress link, read their
/// feedback, or open a patient's code when you are the physio.
class CoachPage extends StatefulWidget {
  const CoachPage({super.key, this.onNotesRead});

  /// Called after unread coach notes were marked as read.
  final VoidCallback? onNotesRead;

  @override
  State<CoachPage> createState() => _CoachPageState();
}

typedef _CoachData = ({List<CoachShareInfo> shares, List<CoachNoteInfo> notes});

class _CoachPageState extends State<CoachPage> {
  Future<_CoachData>? _data;
  final _code = TextEditingController();

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_reload);
    _reload();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_reload);
    _code.dispose();
    super.dispose();
  }

  void _reload() {
    if (!mounted) return;
    setState(() {
      _data = client.auth.isAuthenticated ? _load() : null;
    });
  }

  Future<_CoachData> _load() async {
    final results = await Future.wait([
      client.coach.listShares(),
      client.coach.notes(),
    ]);
    final data = (
      shares: results[0] as List<CoachShareInfo>,
      notes: results[1] as List<CoachNoteInfo>,
    );
    if (data.notes.any((note) => !note.read)) {
      // Show them as new this time, then clear the badge.
      unawaited(
        client.coach.markNotesRead().then((_) => widget.onNotesRead?.call()),
      );
    }
    return data;
  }

  Future<void> _createShare() async {
    final label = await showDialog<String>(
      context: context,
      builder: (context) => const _CoachNameDialog(),
    );
    if (label == null || label.trim().isEmpty) return;
    try {
      final share = await client.coach.createShare(label.trim());
      if (!mounted) return;
      _reload();
      await _copy(share.url, 'Link copied. Send it to ${share.label}.');
    } catch (error) {
      _snack('Could not create the link: $error');
    }
  }

  Future<void> _revoke(CoachShareInfo share) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stop sharing with ${share.label}?'),
        content: const Text(
          'The link stops working immediately. Notes already sent stay here.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Stop sharing'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await client.coach.revokeShare(share.code);
      _reload();
    } catch (error) {
      _snack('Could not revoke: $error');
    }
  }

  Future<void> _copy(String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    _snack(message);
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _openCode() {
    final code = _code.text.trim();
    if (code.isEmpty) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SharedProgressPage(code: code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Physio')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: RefreshIndicator(
              onRefresh: () async {
                _reload();
                try {
                  await _data;
                } catch (_) {}
              },
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.medium),
                children: [
                  Text(
                    'Share with your physiotherapist',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    'Create a private link. Your physio opens it in any '
                    'browser to check how your prescribed exercises are '
                    'going and can send you feedback. No video or pose '
                    'data is shared.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  if (!client.auth.isAuthenticated)
                    SignedOutCard(
                      onSignIn: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const SignInRoute(),
                          ),
                        );
                        _reload();
                      },
                    )
                  else
                    FutureBuilder(
                      future: _data,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const InfoCard(
                            icon: Icons.cloud_off,
                            text:
                                'The server is unreachable. Pull down to '
                                'try again.',
                          );
                        }
                        final data = snapshot.data;
                        if (data == null) {
                          return const Padding(
                            padding: EdgeInsets.all(AppSpacing.large),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _ShareSection(
                          data: data,
                          onCreate: _createShare,
                          onCopy: (share) => _copy(share.url, 'Link copied.'),
                          onRevoke: _revoke,
                        );
                      },
                    ),
                  const SizedBox(height: AppSpacing.extraLarge),
                  Text(
                    'Are you a physiotherapist?',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    'Enter the 8-character code from your patient\'s link to '
                    'review their progress here and send feedback.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          key: const Key('coach_code_field'),
                          controller: _code,
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (_) => _openCode(),
                          decoration: const InputDecoration(
                            labelText: 'Patient code',
                            hintText: 'e.g. 5ZXMYDEF',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.small),
                      FilledButton(
                        key: const Key('open_coach_code'),
                        onPressed: _openCode,
                        child: const Text('Open'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShareSection extends StatelessWidget {
  const _ShareSection({
    required this.data,
    required this.onCreate,
    required this.onCopy,
    required this.onRevoke,
  });

  final _CoachData data;
  final VoidCallback onCreate;
  final ValueChanged<CoachShareInfo> onCopy;
  final ValueChanged<CoachShareInfo> onRevoke;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          key: const Key('create_coach_link'),
          onPressed: onCreate,
          icon: const Icon(Icons.add_link),
          label: const Text('Create physio link'),
        ),
        const SizedBox(height: AppSpacing.medium),
        for (final share in data.shares) ...[
          _ShareCard(
            share: share,
            onCopy: () => onCopy(share),
            onRevoke: () => onRevoke(share),
          ),
          const SizedBox(height: AppSpacing.small),
        ],
        const SizedBox(height: AppSpacing.large),
        Text('Physio feedback', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.small),
        if (data.notes.isEmpty)
          const InfoCard(
            icon: Icons.forum_outlined,
            text: 'Notes your physio sends from the shared page appear here.',
          )
        else
          for (final note in data.notes) ...[
            _NoteCard(note: note),
            const SizedBox(height: AppSpacing.small),
          ],
      ],
    );
  }
}

class _ShareCard extends StatelessWidget {
  const _ShareCard({
    required this.share,
    required this.onCopy,
    required this.onRevoke,
  });

  final CoachShareInfo share;
  final VoidCallback onCopy;
  final VoidCallback onRevoke;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewed = share.lastViewedAt;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medical_services, color: AppColors.lime),
                const SizedBox(width: AppSpacing.small),
                Expanded(child: Text(share.label, style: textTheme.titleLarge)),
                if (share.unreadNoteCount > 0)
                  Badge(label: Text('${share.unreadNoteCount} new')),
              ],
            ),
            const SizedBox(height: AppSpacing.small),
            SelectableText(
              share.url,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.cyan),
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              'Code ${share.code} · viewed ${share.viewCount}× '
              '${viewed == null ? '' : '· last ${_ago(viewed)} '}'
              '· ${share.noteCount} note(s)',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.medium),
            Wrap(
              spacing: AppSpacing.small,
              runSpacing: AppSpacing.small,
              children: [
                OutlinedButton.icon(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('COPY LINK'),
                ),
                OutlinedButton.icon(
                  onPressed: onRevoke,
                  icon: const Icon(Icons.link_off, size: 18),
                  label: const Text('STOP SHARING'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note});

  final CoachNoteInfo note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: note.read
            ? BorderSide.none
            : const BorderSide(color: AppColors.lime),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.message, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.small),
            Text(
              '${note.authorName} · via "${note.shareLabel}" link · '
              '${_ago(note.createdAt)}${note.read ? '' : ' · NEW'}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _CoachNameDialog extends StatefulWidget {
  const _CoachNameDialog();

  @override
  State<_CoachNameDialog> createState() => _CoachNameDialogState();
}

class _CoachNameDialogState extends State<_CoachNameDialog> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Who is this link for?'),
      content: TextField(
        key: const Key('coach_name_field'),
        controller: _name,
        autofocus: true,
        maxLength: 60,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(hintText: 'e.g. Dr. Priya (physio)'),
        onSubmitted: (value) => Navigator.pop(context, value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('confirm_coach_name'),
          onPressed: () => Navigator.pop(context, _name.text),
          child: const Text('Create link'),
        ),
      ],
    );
  }
}

/// A physio's in-app view of a patient's shared progress, with feedback.
class SharedProgressPage extends StatefulWidget {
  const SharedProgressPage({super.key, required this.code});

  final String code;

  @override
  State<SharedProgressPage> createState() => _SharedProgressPageState();
}

class _SharedProgressPageState extends State<SharedProgressPage> {
  late Future<SharedProgress?> _view = _load();
  final _name = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  Future<SharedProgress?> _load() => client.coachView.view(
    widget.code,
    DateTime.now().timeZoneOffset.inMinutes,
  );

  @override
  void dispose() {
    _name.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_name.text.trim().isEmpty || _message.text.trim().isEmpty) return;
    setState(() => _sending = true);
    try {
      final sent = await client.coachView.leaveNote(
        widget.code,
        _name.text,
        _message.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            sent ? 'Feedback sent to your patient.' : 'This link has ended.',
          ),
        ),
      );
      if (sent) {
        _message.clear();
        setState(() => _view = _load());
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not send: $error')));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Patient progress')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: FutureBuilder(
              future: _view,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final view = snapshot.data;
                if (snapshot.hasError || view == null) {
                  return ListView(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    children: [
                      InfoCard(
                        icon: Icons.link_off,
                        text: snapshot.hasError
                            ? 'The server is unreachable. Try again later.'
                            : 'This code is not active. Ask your patient '
                                  'for a new physio link.',
                      ),
                    ],
                  );
                }
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  children: [
                    Text(
                      'Shared with ${view.label}',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    ProgressReportView(report: view.report),
                    if (view.recentWorkouts.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.large),
                      Text('Recent sessions', style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.small),
                      for (final workout in view.recentWorkouts)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.event_note),
                          title: Text(
                            workout.exercises
                                .map(exerciseDisplayName)
                                .join(', '),
                          ),
                          subtitle: Text(
                            '${_date(workout.completedAt)} · '
                            '${workout.totalReps} reps · form '
                            '${workout.averageFormScore?.toStringAsFixed(0) ?? '—'}%'
                            '${workout.note == null ? '' : '\n“${workout.note}”'}',
                          ),
                        ),
                    ],
                    const SizedBox(height: AppSpacing.large),
                    Text('Send feedback', style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.small),
                    TextField(
                      controller: _name,
                      maxLength: 60,
                      decoration: const InputDecoration(
                        labelText: 'Your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    TextField(
                      controller: _message,
                      maxLength: 1000,
                      minLines: 3,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        hintText:
                            'e.g. Good control. Add 2 reps per set next week.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    FilledButton.icon(
                      onPressed: _sending ? null : _send,
                      icon: const Icon(Icons.send),
                      label: const Text('Send to patient'),
                    ),
                    if (view.notes.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.large),
                      Text('Previous notes', style: textTheme.titleLarge),
                      for (final note in view.notes)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.chat_bubble_outline),
                          title: Text(note.message),
                          subtitle: Text(
                            '${note.authorName} · ${_ago(note.createdAt)}',
                          ),
                        ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

String _ago(DateTime time) {
  final diff = DateTime.now().difference(time.toLocal());
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes} min ago';
  if (diff.inDays < 1) return '${diff.inHours} h ago';
  return '${diff.inDays} d ago';
}

String _date(DateTime time) {
  final local = time.toLocal();
  final hh = local.hour.toString().padLeft(2, '0');
  final mm = local.minute.toString().padLeft(2, '0');
  return '${local.day}/${local.month} $hh:$mm';
}
