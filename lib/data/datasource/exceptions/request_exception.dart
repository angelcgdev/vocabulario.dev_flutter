class RequestException implements Exception {
  final String cause;
  const RequestException(this.cause);
}
