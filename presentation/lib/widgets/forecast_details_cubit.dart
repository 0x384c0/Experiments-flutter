import 'package:domain/interactor/interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/utils/geo_location.dart';

import '../data/location_state.dart';
import '../data/weather_state.dart';

class ForecastDetailsCubit extends Cubit<Map<String?, ForecastWeatherState?>> {
  ForecastDetailsCubit(super.initialState);

  late WeatherInteractor interactor = Modular.get<WeatherInteractor>();

  Future<void> refresh() async {
    final dateEpoch = state.entries.first.key;
    if (dateEpoch != null) {
      final position = await GeoLocation.getPosition();
      final forecastModel = await interactor.getForecastItem(
          LocationState.fromPosition(position), dateEpoch);
      final forecastWeatherState = forecastModel != null
          ? ForecastWeatherState.fromModel(forecastModel)
          : null;
      emit({dateEpoch: forecastWeatherState});
    }
  }
}
