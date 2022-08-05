import 'package:domain/usecases/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DomainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<WeatherInteractor>(
          (i) => WeatherInteractorImpl(i()),
          export: true,
        ),
      ];
}
