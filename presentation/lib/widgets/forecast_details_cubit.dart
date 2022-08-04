import 'package:domain/data/forecast_model.dart';
import 'package:domain/interactor/interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/location_state.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/geo_location.dart';
import 'package:presentation/utils/mapper.dart';

class ForecastDetailsCubit extends Cubit<Map<String?, ForecastWeatherState?>> {
  ForecastDetailsCubit(super.initialState);

  late WeatherInteractor interactor = Modular.get<WeatherInteractor>();
  late Mapper<ForecastItemModel, ForecastWeatherState> forecastItemModelMapper = Modular.get();

  Future<void> refresh() async {
    final dateEpoch = state.entries.first.key;
    return dateEpoch != null
        ? GeoLocation.getPosition()
            .then((value) => LocationState.fromPosition(value))
            .then((value) => interactor.getForecastItem(value, dateEpoch))
            .then(forecastItemModelMapper.mapOptional)
            .then((value) => emit({dateEpoch: value}))
        : Future.error(Exception("dateEpoch is null"));
  }
}
