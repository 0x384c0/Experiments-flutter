class ErrorModel {
  ErrorModel(this.message);

  final String? message;

  @override
  String toString() => message ?? "";
}
