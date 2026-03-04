import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/widgets/forms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

@Deprecated('use auto_route directly')
/// Navigation for feature
abstract class FormsNavigator {
  Widget home();
}

/// Private implementation of navigation
class NavigatorImpl implements FormsNavigator {
  @override
  home() => const FormsScreen();
}
