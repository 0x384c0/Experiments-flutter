import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/navigation/weather_navigator.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<WeatherNavigator>(
          (i) => WeatherNavigatorImpl(),
          export: true,
        ),
      ];
}
