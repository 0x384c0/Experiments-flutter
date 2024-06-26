import 'package:features_forms_presentation/src/widgets/forms_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsRoutesModule extends Module {
  static const path = '/forms';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FormsPage());
  }
}
