import 'package:features_experiments_presentation/src/navigation/module.dart';
import 'package:features_experiments_presentation/src/widgets/flutter_layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for feature
abstract class ExperimentsNavigator {
  Widget homePage();

  back();

  toMasonryGrid();
}

/// Private implementation of navigation
class NavigatorImpl implements ExperimentsNavigator {
  @override
  homePage() => FlutterLayoutPage();

  @override
  back() => Modular.to.pop();

  @override
  toMasonryGrid() => Modular.to.pushNamed(ExperimentsRoutesModule.path + ExperimentsRoutesModule.masonryGrid);
}
