import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'coach_service.dart';

/// `GET /coach/:code` renders an patient's shared progress for a coach in any
/// browser. `POST` stores the physio's note and redirects back.
class CoachWebRoute extends Route {
  CoachWebRoute() : super(methods: {Method.get, Method.post});

  static const _codeParam = PathParam<String>(#code, _identity);
  static String _identity(String value) => value;

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final code = request.pathParameters.get(_codeParam);
    final share = await CoachService.findActive(session, code);
    if (share == null) {
      // 410 rather than 404 so the app-shell fallback does not replace it.
      return _html(410, _page('Link unavailable', _unavailable));
    }

    if (request.method == Method.post) {
      final form = Uri.splitQueryString(await request.readAsString());
      var saved = false;
      try {
        saved = await CoachService.addNote(
          session,
          share,
          authorName: form['name'] ?? '',
          message: form['message'] ?? '',
        );
      } on ArgumentError {
        saved = false;
      }
      return Response.seeOther(
        Uri.parse('/physio/${share.code}?note=${saved ? 'sent' : 'error'}'),
      );
    }

    // Browsers do not send a timezone; IST is the default audience, and the
    // app passes the exact offset when coaches open codes there.
    final offset = int.tryParse(request.queryParameters.raw['tz'] ?? '') ?? 330;
    final progress = await CoachService.sharedProgress(
      session,
      share,
      utcOffsetMinutes: offset,
    );
    final noteStatus = request.queryParameters.raw['note'];
    return _html(
      200,
      _page(
        '${progress.label} · Right Posture',
        _body(progress, share.code, offset, noteStatus),
      ),
    );
  }

  Response _html(int status, String html) => Response(
    status,
    body: Body.fromString(html, mimeType: MimeType.html),
    headers: Headers.build((h) {
      h.cacheControl = CacheControlHeader(noStore: true);
    }),
  );
}

final _esc = const HtmlEscape();

const _exerciseNames = {
  'squat': 'Squat',
  'bicepCurl': 'Bicep Curl',
  'lateralRaise': 'Lateral Raise',
  'shoulderPress': 'Shoulder Press',
  'reverseLunge': 'Reverse Lunge',
  'jumpingJack': 'Jumping Jack',
};

String _exercise(String id) => _exerciseNames[id] ?? id;

String _pct(double? value) =>
    value == null ? '—' : '${value.toStringAsFixed(0)}%';

String _date(DateTime value, int offsetMinutes) {
  final local = value.toUtc().add(Duration(minutes: offsetMinutes));
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final hh = local.hour.toString().padLeft(2, '0');
  final mm = local.minute.toString().padLeft(2, '0');
  return '${local.day} ${months[local.month - 1]} ${local.year}, $hh:$mm';
}

const _unavailable = '''
<section class="card"><h1>This link is not available</h1>
<p class="muted">It may have been revoked by the patient. Ask them for a new
physio link from the Right Posture app.</p></section>''';

String _body(SharedProgress p, String code, int offset, String? noteStatus) {
  final r = p.report;
  final b = StringBuffer()
    ..write('<header><div class="brand">RIGHT POSTURE</div>')
    ..write('<p class="muted">Progress shared with</p>')
    ..write('<h1>${_esc.convert(p.label)}</h1>')
    ..write(
      '<p class="muted">Computed by Serverpod from every synced '
      'exercise session. Video and pose data never leave the patient&rsquo;s '
      'phone.</p></header>',
    )
    ..write('<section class="stats">')
    ..write(_stat('Sessions', '${r.workoutCount}'))
    ..write(_stat('Sets', '${r.setCount}'))
    ..write(_stat('Reps', '${r.totalReps}'))
    ..write(_stat('Day streak', '${r.streakDays}'))
    ..write(_stat('Active days (28)', '${r.activeDaysLast28}'))
    ..write('</section>');

  if (r.exercises.isEmpty) {
    b.write(
      '<section class="card"><p class="muted">No sessions synced '
      'yet.</p></section>',
    );
  }
  for (final e in r.exercises) {
    b
      ..write(
        '<section class="card"><h2>${_esc.convert(_exercise(e.exercise))}'
        '</h2>',
      )
      ..write(
        '<p>${e.sets} sets · ${e.reps} reps · avg form '
        '${_pct(e.averageFormScore)} · best ${_pct(e.bestFormScore)}</p>',
      )
      ..write(
        '<p class="muted">This week: ${e.weeklySets} sets, '
        '${e.weeklyReps} reps, form ${_pct(e.weeklyFormScore)}</p>',
      )
      ..write(
        '<div class="bar" role="img" aria-label="${e.goodReps} good, '
        '${e.warningReps} warning, ${e.degradedReps} degraded reps">',
      )
      ..write(_segment(e.goodReps, e, 'good'))
      ..write(_segment(e.warningReps, e, 'warn'))
      ..write(_segment(e.degradedReps, e, 'bad'))
      ..write(
        '</div><p class="legend"><span class="dot good"></span>'
        '${e.goodReps} good <span class="dot warn"></span>${e.warningReps} '
        'warning <span class="dot bad"></span>${e.degradedReps} '
        'degraded</p>',
      );
    if (e.topIssue != null) {
      b.write(
        '<p class="warn-text">Most frequent issue: '
        '${_esc.convert(e.topIssue!)} (${e.topIssueCount}×)</p>',
      );
    }
    if (e.insights.isNotEmpty) {
      b.write('<ul>');
      for (final insight in e.insights) {
        b.write('<li>${_esc.convert(insight)}</li>');
      }
      b.write('</ul>');
    }
    b.write('</section>');
  }

  if (p.recentWorkouts.isNotEmpty) {
    b.write(
      '<section class="card"><h2>Recent sessions</h2><table>'
      '<tr><th>When</th><th>Exercises</th><th>Reps</th><th>Form</th></tr>',
    );
    for (final w in p.recentWorkouts) {
      b.write(
        '<tr><td>${_date(w.completedAt, offset)}</td><td>'
        '${_esc.convert(w.exercises.map(_exercise).join(', '))}'
        '${w.note == null ? '' : '<div class="muted">“${_esc.convert(w.note!)}”</div>'}'
        '</td><td>${w.totalReps}</td><td>${_pct(w.averageFormScore)}</td>'
        '</tr>',
      );
    }
    b.write('</table></section>');
  }

  b.write('<section class="card"><h2>Leave feedback</h2>');
  if (noteStatus == 'sent') {
    b.write('<p class="ok">Sent. The patient will see it in the app.</p>');
  } else if (noteStatus == 'error') {
    b.write(
      '<p class="warn-text">Could not send. Check your name and '
      'message and try again.</p>',
    );
  }
  b
    ..write('<form method="post" action="/physio/$code">')
    ..write(
      '<label>Your name<input name="name" maxlength="'
      '${CoachService.maxAuthorLength}" required></label>',
    )
    ..write(
      '<label>Message<textarea name="message" rows="4" maxlength="'
      '${CoachService.maxNoteLength}" required placeholder="e.g. Good knee '
      'control this week. Add 2 reps per set next week."></textarea>'
      '</label>',
    )
    ..write('<button type="submit">Send to patient</button></form>');
  if (p.notes.isNotEmpty) {
    b.write('<h3>Previous notes</h3>');
    for (final n in p.notes) {
      b.write(
        '<blockquote>${_esc.convert(n.message)}<cite>— '
        '${_esc.convert(n.authorName)}, ${_date(n.createdAt, offset)}'
        '</cite></blockquote>',
      );
    }
  }
  b.write(
    '</section><footer class="muted">Built with Serverpod · Right '
    'Posture supports home exercise programmes and does not replace your physiotherapist.</footer>',
  );
  return b.toString();
}

String _stat(String label, String value) =>
    '<div class="stat"><b>$value</b><span>$label</span></div>';

String _segment(int count, ExerciseProgress e, String kind) {
  final total = e.goodReps + e.warningReps + e.degradedReps;
  if (total == 0 || count == 0) return '';
  final width = (count / total * 100).toStringAsFixed(1);
  return '<span class="$kind" style="width:$width%"></span>';
}

String _page(String title, String body) =>
    '''<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>${_esc.convert(title)}</title>
<style>
:root{--bg:#131316;--surface:#1f1f22;--high:#2a2a2d;--lime:#c3f400;--cyan:#9cf0ff;
--text:#fff;--muted:#bebec6;--good:#22c55e;--warn:#ffb84d;--bad:#ff5a5a;--line:#444933}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--text);
font:16px/1.5 system-ui,-apple-system,Segoe UI,Roboto,sans-serif}
main{max-width:760px;margin:0 auto;padding:24px 16px 48px}
.brand{color:var(--lime);font-weight:800;letter-spacing:.08em}
h1{font-size:32px;margin:0 0 8px}h2{margin:0 0 8px;font-size:20px}h3{margin:24px 0 8px}
.muted{color:var(--muted)}.ok{color:var(--good)}.warn-text{color:var(--warn)}
.card{background:var(--surface);border-radius:24px;padding:20px;margin:16px 0}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(110px,1fr));gap:8px;margin:16px 0}
.stat{background:var(--high);border-radius:12px;padding:14px}.stat b{display:block;
color:var(--lime);font-size:24px}.stat span{color:var(--muted);font-size:14px}
.bar{display:flex;height:10px;border-radius:999px;overflow:hidden;background:var(--high);margin:12px 0 4px}
.bar .good,.dot.good{background:var(--good)}.bar .warn,.dot.warn{background:var(--warn)}
.bar .bad,.dot.bad{background:var(--bad)}.legend{font-size:14px;color:var(--muted);margin:0}
.dot{display:inline-block;width:10px;height:10px;border-radius:50%;margin:0 4px 0 8px}
ul{padding-left:20px;margin:8px 0 0}li{margin:4px 0}
table{width:100%;border-collapse:collapse;font-size:14px}th,td{text-align:left;padding:8px 6px;
border-bottom:1px solid var(--line);vertical-align:top}th{color:var(--muted);font-weight:600}
label{display:block;margin:12px 0;color:var(--muted);font-size:14px}
input,textarea{display:block;width:100%;margin-top:6px;padding:12px;border-radius:12px;
border:1px solid var(--line);background:var(--bg);color:var(--text);font:inherit}
button{background:var(--lime);color:var(--bg);border:0;border-radius:999px;padding:14px 22px;
font-weight:700;font-size:16px;cursor:pointer}
blockquote{margin:12px 0;padding:12px 16px;background:var(--high);border-radius:12px}
cite{display:block;color:var(--muted);font-size:13px;margin-top:6px;font-style:normal}
footer{margin-top:32px;font-size:13px;text-align:center}
</style></head><body><main>$body</main></body></html>''';
