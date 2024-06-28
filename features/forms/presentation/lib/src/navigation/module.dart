import 'package:features_forms_presentation/src/widgets/form_validation_page.dart';
import 'package:features_forms_presentation/src/widgets/forms_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsRoutesModule extends Module {
  static const path = '/forms';
  static const formValidation = '/form_validation';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FormsPage());
    r.child(formValidation, child: (context) => const FormValidationPage());
  }
}
