import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/mapper/forecast_item_model_mapper.dart';
import 'package:features_weather_presentation/mapper/forecast_model_mapper.dart';
import 'package:features_weather_presentation/navigation/navigator.dart';
import 'package:features_weather_presentation/utils/geo_location_provider.dart';
import 'package:common_domain/mapper/mapper.dart';

class WeatherPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<Mapper<ForecastModel, WeatherState>>(ForecastModelMapper.new);
    i.add<Mapper<ForecastItemModel, ForecastWeatherState>>(ForecastItemModelMapper.new);
    i.add<WeatherNavigator>(NavigatorImpl.new);
    i.add<GeoLocationProvider>(GeoLocationProviderImpl.new);
  }
}
