import 'package:flutter/material.dart';

import '../theme/dimensions.dart';
import '../theme/styles.dart';
import '../theme/theme_colors.dart';

extension CommonLocalizationBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ThemeColors get themeColors => theme.extension<ThemeColors>()!;

  Dimensions get dimensions => theme.extension<Dimensions>()!;

  Styles get styles => Styles(this);
}
