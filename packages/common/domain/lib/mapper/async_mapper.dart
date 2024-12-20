abstract class AsyncMapper<IN, OUT> {
  Future<OUT> map(IN input);

  Future<OUT?> mapOptional(IN? input) async => input != null ? await map(input) : null;
}
