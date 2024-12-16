import 'package:flutter/material.dart';

import '../extensions/build_context_theme.dart';
import '../widgets/decorators/outer_border_decoration.dart';

class Styles {
  Styles(this._context);

  final BuildContext _context;

  ButtonStyle get filledButtonTertiary =>
      FilledButton.styleFrom(backgroundColor: Theme.of(_context).colorScheme.tertiary);

  late ButtonStyle textButtonGray = TextButton.styleFrom(
    backgroundColor: _context.themeColors.grey.shade50,
    foregroundColor: _context.themeColors.grey.shade700,
  );

  Decoration get selectedDecoration => OuterBorderDecoration(
        color: _context.themeColors.grey.shade100,
        width: 4,
        radius: 10,
        offset: 2,
      );

  Decoration get unselectedDecoration => const BoxDecoration();
}
