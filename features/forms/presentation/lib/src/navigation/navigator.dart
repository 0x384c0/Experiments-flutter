import 'package:features_forms_presentation/src/widgets/forms_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for weather feature
abstract class FormsNavigator {
  Widget homePage();

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements FormsNavigator {
  @override
  homePage() => const FormsPage();

  @override
  back() => Modular.to.pop();
}
