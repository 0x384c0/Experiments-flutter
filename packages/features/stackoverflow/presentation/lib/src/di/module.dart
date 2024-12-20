import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StackOverflowPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<StackOverflowNavigator>(NavigatorImpl.new);
  }
}
