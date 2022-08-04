abstract class Mapper<IN, OUT> {
  OUT map(IN input);

  OUT? mapOptional(IN? input) => input != null ? map(input) : null;
}
