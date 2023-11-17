import 'package:features_weather_domain/usecases/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeatherDomainModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<WeatherInteractor>(() => WeatherInteractorImpl(Modular.get()));
  }
}
