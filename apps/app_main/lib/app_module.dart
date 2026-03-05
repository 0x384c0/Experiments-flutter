import 'package:features_weather_data/features_weather_data.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  final bool isRealDevice;

  AppModule({required this.isRealDevice});

  // class names for modules cannot be same
  @override
  List<Module> get imports => [
        WeatherDomainModule([
          WeatherPresentationModule(isRealDevice: isRealDevice),
          WeatherDataModule(),
        ]),
      ];
}
