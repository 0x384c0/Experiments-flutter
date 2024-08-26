class ErrorModel {
  ErrorModel(this.message, this.type);

  final String? message;
  final ErrorModelType type;

  @override
  String toString() => message ?? "";
}

enum ErrorModelType { unknown, connectionError, badResponse }
