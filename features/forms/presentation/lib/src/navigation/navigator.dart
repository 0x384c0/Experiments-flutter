import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/widgets/forms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for feature
abstract class FormsNavigator {
  Widget home();

  Future<Object?> toFormzzValidation();

  Future<Object?> toMaterialValidation();

  back();
}

/// Private implementation of navigation
class NavigatorImpl implements FormsNavigator {
  @override
  home() => const FormsScreen();

  @override
  toFormzzValidation() => Modular.to.pushNamed('${FormsRoutesModule.path}${FormsRoutesModule.formzzValidation}');

  @override
  toMaterialValidation() => Modular.to.pushNamed('${FormsRoutesModule.path}${FormsRoutesModule.materialValidation}');

  @override
  back() => Modular.to.pop();
}
