import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/mapper/forecast_item_model_mapper.dart';
import 'package:features_weather_presentation/mapper/forecast_model_mapper.dart';
import 'package:features_weather_presentation/navigation/navigator.dart';
import 'package:features_weather_presentation/utils/geo_location_provider.dart';
import 'package:features_weather_presentation/utils/mapper.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Navigator>(
          (i) => NavigatorImpl(),
          export: true,
        ),
        Bind<GeoLocationProvider>(
          (i) => GeoLocationProviderImpl(),
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
