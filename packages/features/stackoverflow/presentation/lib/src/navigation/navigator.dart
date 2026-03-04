import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/questions_screen.dart';

@Deprecated('use auto_route directly')
/// Navigation for stackoverflow feature
abstract class StackOverflowNavigator {
  Widget home();
}

/// Private implementation if stackoverflow navigation
class NavigatorImpl implements StackOverflowNavigator {
  @override
  home() => const ProviderScope(child: QuestionsScreen());
}
