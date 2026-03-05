import 'package:features_forms_presentation/src/widgets/forms_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Deprecated('use auto_route directly')
/// Navigation for feature
abstract class FormsNavigator {
  Widget home();
}

/// Private implementation of navigation
@Injectable(as: FormsNavigator)
class NavigatorImpl implements FormsNavigator {
  @override
  home() => const FormsScreen();
}
