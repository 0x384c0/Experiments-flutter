import 'package:domain/data/forecast_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/mapper/forecast_item_model_mapper.dart';
import 'package:presentation/mapper/forecast_model_mapper.dart';
import 'package:presentation/navigation/weather_navigator.dart';
import 'package:presentation/utils/geo_location_manager.dart';
import 'package:presentation/utils/mapper.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<WeatherNavigator>(
          (i) => WeatherNavigatorImpl(),
          export: true,
        ),
        Bind<GeoLocationManager>(
          (i) => GeoLocationManagerImpl(),
          export: true,
        ),
        Bind<Mapper<ForecastModel, WeatherState>>(
          (i) => ForecastModelMapper(),
          export: true,
        ),
        Bind<Mapper<ForecastItemModel, ForecastWeatherState>>(
          (i) => ForecastItemModelMapper(),
          export: true,
        ),
      ];
}
