class Failure implements Exception {
  final String message;
  final dynamic data;

  Failure(this.message, {this.data});

  @override
  String toString() => '${runtimeType.toString()} (message: $message)';
}

class ConnectionException extends Failure {
  ConnectionException(super.message);
}

class UnavaliableServiceException extends Failure {
  UnavaliableServiceException(super.message);
}

class BadRequestException extends Failure {
  BadRequestException(super.message);
}

class AuthorizationException extends Failure {
  AuthorizationException(super.message);
}

class RequestNotFoundException extends Failure {
  RequestNotFoundException(super.message);
}
