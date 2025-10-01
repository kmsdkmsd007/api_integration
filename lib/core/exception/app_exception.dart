abstract class AppException implements Exception {}

class ServerException extends AppException {
  final String message;
  ServerException(this.message);
}

class NetworkException extends AppException {
  final String message;
  NetworkException(this.message);
}

class TokenMissingException extends AppException {
  final String message;
  TokenMissingException(this.message);
}
