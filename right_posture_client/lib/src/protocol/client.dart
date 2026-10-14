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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:right_posture_client/src/protocol/coach/coach_note_info.dart'
    as _i4e57982;
import 'package:right_posture_client/src/protocol/coach/coach_share_info.dart'
    as _iv4v21xh;
import 'package:right_posture_client/src/protocol/coach/shared_progress.dart'
    as _iffnctep;
import 'package:right_posture_client/src/protocol/progress/progress_report.dart'
    as _i7mzik6b;
import 'package:right_posture_client/src/protocol/workouts/sync_status.dart'
    as _iuq6buu5;
import 'package:right_posture_client/src/protocol/workouts/synced_workout.dart'
    as _i7y060ko;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Guest accounts: a device can start syncing immediately and the user can
/// try the full app without email verification.
/// {@category Endpoint}
class EndpointAnonymousIdp extends _iaic.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _ida.Future<_iacc.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Athlete side of coach sharing: manage share links and read coach notes.
/// {@category Endpoint}
class EndpointCoach extends _isc.EndpointRef {
  EndpointCoach(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'coach';

  /// Creates a share link for a coach named [label].
  _ida.Future<_iv4v21xh.CoachShareInfo> createShare(String label) =>
      caller.callServerEndpoint<_iv4v21xh.CoachShareInfo>(
        'coach',
        'createShare',
        {'label': label},
      );

  /// The user's active share links, newest first.
  _ida.Future<List<_iv4v21xh.CoachShareInfo>> listShares() =>
      caller.callServerEndpoint<List<_iv4v21xh.CoachShareInfo>>(
        'coach',
        'listShares',
        {},
      );

  /// Stops a share link from working. Notes stay readable in the app.
  _ida.Future<bool> revokeShare(String code) => caller.callServerEndpoint<bool>(
    'coach',
    'revokeShare',
    {'code': code},
  );

  /// Notes coaches left on any of the user's links, newest first.
  _ida.Future<List<_i4e57982.CoachNoteInfo>> notes() =>
      caller.callServerEndpoint<List<_i4e57982.CoachNoteInfo>>(
        'coach',
        'notes',
        {},
      );

  /// Marks every note on the user's links as read. Returns how many changed.
  _ida.Future<int> markNotesRead() => caller.callServerEndpoint<int>(
    'coach',
    'markNotesRead',
    {},
  );
}

/// Coach side: open a share code in the app and leave feedback. No account
/// needed; the unguessable code is the credential.
/// {@category Endpoint}
class EndpointCoachView extends _isc.EndpointRef {
  EndpointCoachView(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'coachView';

  /// Progress shared through [code], or null if the link is unknown or revoked.
  _ida.Future<_iffnctep.SharedProgress?> view(
    String code,
    int utcOffsetMinutes,
  ) => caller.callServerEndpoint<_iffnctep.SharedProgress?>(
    'coachView',
    'view',
    {
      'code': code,
      'utcOffsetMinutes': utcOffsetMinutes,
    },
  );

  /// Leaves a note for the athlete. Returns false if the link is not active.
  _ida.Future<bool> leaveNote(
    String code,
    String authorName,
    String message,
  ) => caller.callServerEndpoint<bool>(
    'coachView',
    'leaveNote',
    {
      'code': code,
      'authorName': authorName,
      'message': message,
    },
  );
}

/// Progress analytics computed on the server from every synced workout.
/// {@category Endpoint}
class EndpointProgress extends _isc.EndpointRef {
  EndpointProgress(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'progress';

  /// Builds the user's progress report. [utcOffsetMinutes] is the phone's
  /// timezone offset so days, weeks and streaks match the user's calendar.
  _ida.Future<_i7mzik6b.ProgressReport> report(int utcOffsetMinutes) =>
      caller.callServerEndpoint<_i7mzik6b.ProgressReport>(
        'progress',
        'report',
        {'utcOffsetMinutes': utcOffsetMinutes},
      );
}

/// Cloud backup for finished workouts.
///
/// The app uploads the same bounded summary JSON it keeps locally. The server
/// validates it with the shared core engine, stores it once per `clientId`, and
/// indexes every set so progress can be queried across devices.
/// {@category Endpoint}
class EndpointWorkout extends _isc.EndpointRef {
  EndpointWorkout(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workout';

  /// Stores a workout. Uploading the same `clientId` again is a no-op, so the
  /// app can safely retry after a lost connection. Returns true when stored.
  _ida.Future<bool> upload(
    String clientId,
    String payload,
  ) => caller.callServerEndpoint<bool>(
    'workout',
    'upload',
    {
      'clientId': clientId,
      'payload': payload,
    },
  );

  /// Updates the journal note of a synced workout.
  _ida.Future<bool> updateNote(
    String clientId,
    String? note,
  ) => caller.callServerEndpoint<bool>(
    'workout',
    'updateNote',
    {
      'clientId': clientId,
      'note': note,
    },
  );

  /// Returns the user's most recent workouts, oldest first, for restoring
  /// local history on any device.
  _ida.Future<List<_i7y060ko.SyncedWorkout>> list() =>
      caller.callServerEndpoint<List<_i7y060ko.SyncedWorkout>>(
        'workout',
        'list',
        {},
      );

  /// Totals for the account screen.
  _ida.Future<_iuq6buu5.SyncStatus> status() =>
      caller.callServerEndpoint<_iuq6buu5.SyncStatus>(
        'workout',
        'status',
        {},
      );

  /// Deletes every synced workout of the signed-in user.
  _ida.Future<int> deleteAll() => caller.callServerEndpoint<int>(
    'workout',
    'deleteAll',
    {},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    anonymousIdp = EndpointAnonymousIdp(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    coach = EndpointCoach(this);
    coachView = EndpointCoachView(this);
    progress = EndpointProgress(this);
    workout = EndpointWorkout(this);
    modules = Modules(this);
  }

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCoach coach;

  late final EndpointCoachView coachView;

  late final EndpointProgress progress;

  late final EndpointWorkout workout;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'anonymousIdp': anonymousIdp,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'coach': coach,
    'coachView': coachView,
    'progress': progress,
    'workout': workout,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
