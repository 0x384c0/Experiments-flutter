import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<FormsNavigator>(NavigatorImpl.new);
  }
}
