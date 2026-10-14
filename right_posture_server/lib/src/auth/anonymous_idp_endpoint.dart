import 'package:serverpod_auth_idp_server/providers/anonymous.dart';

/// Guest accounts: a device can start syncing immediately and the user can
/// try the full app without email verification.
class AnonymousIdpEndpoint extends AnonymousIdpBaseEndpoint {}
