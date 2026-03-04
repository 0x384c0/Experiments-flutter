import 'package:features_experiments_presentation/src/widgets/flutter_layout_screen.dart';
import 'package:flutter/material.dart';

@Deprecated('use https://pub.dev/packages/auto_route#using-pageview')
/// Navigation for feature
abstract class ExperimentsNavigator {
  Widget home();
}

/// Private implementation of navigation
class NavigatorImpl implements ExperimentsNavigator {
  @override
  home() => const FlutterLayoutScreen();
}
