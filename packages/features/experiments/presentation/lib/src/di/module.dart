import 'package:features_experiments_presentation/src/navigation/navigator.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExperimentsPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<ExperimentsNavigator>(NavigatorImpl.new);
  }
}
