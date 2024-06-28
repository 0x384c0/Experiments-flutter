import 'package:features_forms_presentation/src/widgets/formzz_validation_page.dart';
import 'package:features_forms_presentation/src/widgets/forms_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsRoutesModule extends Module {
  static const path = '/forms';
  static const formzzValidation = '/formzz_validation';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FormsPage());
    r.child(formzzValidation, child: (context) => const FormzzValidationPage());
  }
}
