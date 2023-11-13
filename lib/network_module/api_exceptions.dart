/// AppException class
///
/// Here we create out generic exceptions,
/// where we send msg and prefix to explain it better

class AppException implements Exception {
  AppException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '$_prefix\n$_message';
  }
}

class BadRequestValidationException implements Exception {
  BadRequestValidationException.fromJson(dynamic json, {int? code}) {
    print(json);
    statusCode = code;
    detail = json['detail'] as String;
    // ignore: always_specify_types
    errors = {};

    if (json['errors'] != null && json['errors'] is Map<String, dynamic>) {
      final Map<String, List<String>> parsedErrors = <String, List<String>>{};
      (json['errors'] as Map<String, dynamic>)
          .forEach((String key, dynamic value) {
        // ignore: always_specify_types
        final List<String> lErrors = (value as List).cast<String>();
        if (lErrors != null) {
          parsedErrors[key] = lErrors;
        }
      });

      print(parsedErrors);

      errors = parsedErrors;
    }

    print(detail);
  }

  String? detail;
  int? statusCode;
  Map<String, List<String>>? errors;

  @override
  String toString() {
    return detail!;
  }
}

class InternetException extends AppException {
  InternetException([String? message])
      : super(message, 'Error During Communication');

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([dynamic message])
      : super(message, 'Invalid Request Exception');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([dynamic message]) : super(message, 'Unauthorized!');
}

class InvalidInputException extends AppException {
  InvalidInputException([dynamic message])
      : super(message, 'Invalid Input Exception');
}

class AuthenticationException extends AppException {
  AuthenticationException([dynamic message])
      : super(message, 'Authentication Exception');
}
