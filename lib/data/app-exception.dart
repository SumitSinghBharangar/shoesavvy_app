class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error in Communication");
}

class BadDataException extends AppException {
  BadDataException([String? message]) : super(message, "Invalid request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, "Unauthorised request");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, "Unauthorised request");
}
