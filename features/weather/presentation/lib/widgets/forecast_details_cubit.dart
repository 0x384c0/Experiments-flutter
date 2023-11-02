import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/usecases/interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/utils/geo_location_provider.dart';
import 'package:common_domain/mapper/mapper.dart';

class ForecastDetailsCubit extends Cubit<Map<String?, ForecastWeatherState?>> {
  ForecastDetailsCubit(super.initialState);

  late GeoLocationProvider geoLocationManager = Modular.get();
  late WeatherInteractor interactor = Modular.get<WeatherInteractor>();
  late Mapper<ForecastItemModel, ForecastWeatherState> forecastItemModelMapper = Modular.get();

  Future<void> refresh() async {
    final dateEpoch = state.entries.first.key;
    return dateEpoch != null
        ? geoLocationManager
            .getLocation()
            .then((value) => interactor.getForecastItem(value, dateEpoch))
            .then(forecastItemModelMapper.mapOptional)
            .then((value) => emit({dateEpoch: value}))
        : Future.error(Exception("dateEpoch is null"));
  }
}
