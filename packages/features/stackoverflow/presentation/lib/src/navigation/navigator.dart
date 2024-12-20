import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/questions_screen.dart';

/// Navigation for stackoverflow feature
abstract class StackOverflowNavigator {
  Widget home();

  back();
}

/// Private implementation if stackoverflow navigation
class NavigatorImpl implements StackOverflowNavigator {
  @override
  home() => const ProviderScope(child: QuestionsScreen());

  @override
  back() => Modular.to.pop();
}
