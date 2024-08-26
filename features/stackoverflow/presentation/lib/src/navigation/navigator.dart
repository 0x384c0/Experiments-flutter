import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/home.dart';

/// Navigation for stackoverflow feature
abstract class StackOverflowNavigator {
  Widget homePage();

  back();
}

/// Private implementation if stackoverflow navigation
class NavigatorImpl implements StackOverflowNavigator {
  @override
  homePage() => const ProviderScope(child: MyHomePage());

  @override
  back() => Modular.to.pop();
}
