class AuthAsyncException implements Exception {
  final String error;

  AuthAsyncException(this.error);

  @override
  String toString() {
    return 'auth error: $error';
  }
}
