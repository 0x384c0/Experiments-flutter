import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/widgets/forms_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for feature
abstract class FormsNavigator {
  Widget homePage();

  Future<Object?> toFormValidation();

  back();
}

/// Private implementation of navigation
class NavigatorImpl implements FormsNavigator {
  @override
  homePage() => const FormsPage();

  @override
  toFormValidation() => Modular.to.pushNamed('${FormsRoutesModule.path}${FormsRoutesModule.formValidation}');

  @override
  back() => Modular.to.pop();
}
