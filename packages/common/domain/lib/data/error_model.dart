class ErrorModel {
  ErrorModel({
    this.message,
    this.code,
    this.stackTrace,
    required this.type,
  });

  final String? message;
  final int? code;
  final StackTrace? stackTrace;
  final ErrorModelType type;

  @override
  String toString() => message ?? '';

  static int unauthorizedCode = 401;

  bool get isUnauthorized => code == unauthorizedCode;
}

enum ErrorModelType {
  unknown,
  connectionError,
  badResponse,
}
