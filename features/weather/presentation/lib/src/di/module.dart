import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/weather_state.dart';
import '../mapper/forecast_item_model_mapper.dart';
import '../mapper/forecast_model_mapper.dart';
import '../navigation/navigator.dart';
import '../utils/geo_location_provider.dart';

class WeatherPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<Mapper<ForecastModel, WeatherState>>(ForecastModelMapper.new);
    i.addSingleton<Mapper<ForecastItemModel, ForecastWeatherState>>(ForecastItemModelMapper.new);
    i.addSingleton<WeatherNavigator>(NavigatorImpl.new);
    i.addSingleton<GeoLocationProvider>(GeoLocationProviderImpl.new);
  }
}
