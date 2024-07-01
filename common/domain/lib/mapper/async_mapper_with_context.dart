import 'dart:async';

import 'package:flutter/widgets.dart';

import 'async_mapper.dart';

/// Mapper to be used within UI
/// [withContext] must be called before usage
abstract class AsyncMapperWithContext<IN, OUT> extends AsyncMapper<IN, OUT> {
  late BuildContext _context;

  AsyncMapperWithContext<IN, OUT> withContext(BuildContext context) {
    this._context = context;
    return this;
  }

  @override
  map(input) => mapWithContext(input, _context);

  Future<OUT> mapWithContext(IN input, BuildContext context);
}
