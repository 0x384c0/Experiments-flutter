import 'package:flutter/widgets.dart';

import 'mapper.dart';

/// Mapper to be used within UI
/// [withContext] must be called before usage
abstract class MapperWithContext<IN, OUT> extends Mapper<IN, OUT> {
  late BuildContext _context;

  MapperWithContext<IN, OUT> withContext(BuildContext context) {
    this._context = context;
    return this;
  }

  @override
  map(input) => mapWithContext(input, _context);

  OUT mapWithContext(IN input, BuildContext context);
}
