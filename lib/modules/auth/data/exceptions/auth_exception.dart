class AuthException implements Exception {
  final String cause;
  const AuthException(this.cause);
}
