import 'package:features_experiments_presentation/src/widgets/flutter_layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for feature
abstract class ExperimentsNavigator {
  Widget homePage();

  back();
}

/// Private implementation of navigation
class NavigatorImpl implements ExperimentsNavigator {
  @override
  homePage() => const FlutterLayoutPage();

  @override
  back() => Modular.to.pop();
}
