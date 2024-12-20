import 'package:flutter_modular/flutter_modular.dart';

import '../../features_weather_domain.dart';

class WeatherDomainModule extends Module {
  WeatherDomainModule(this.imports);

  @override
  final List<Module> imports;

  @override
  exportedBinds(Injector i) {
    i.add<WeatherInteractor>(WeatherInteractorImpl.new);
  }
}
