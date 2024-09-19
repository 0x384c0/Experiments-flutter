import 'package:features_forms_presentation/src/widgets/formzz_validation_screen.dart';
import 'package:features_forms_presentation/src/widgets/forms_screen.dart';
import 'package:features_forms_presentation/src/widgets/material_validation_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsRoutesModule extends Module {
  static const path = '/forms';
  static const formzzValidation = '/formzz_validation';
  static const materialValidation = '/material_validation';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FormsScreen());
    r.child(formzzValidation, child: (context) => const FormzzValidationScreen());
    r.child(materialValidation, child: (context) => const MaterialValidationScreen());
  }
}
