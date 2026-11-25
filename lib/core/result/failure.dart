final class Failure {
  const Failure(this.message);

  final String message;
}

final class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}
