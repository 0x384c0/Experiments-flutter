import 'package:flutter_modular/flutter_modular.dart';

import '../../features_weather_domain.dart';

class WeatherDomainModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<WeatherInteractor>(() => WeatherInteractorImpl(Modular.get()));
  }
}
