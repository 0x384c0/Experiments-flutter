import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/page_state/screen_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/weather_state.dart';
import '../navigation/navigator.dart';
import '../utils/geo_location_provider.dart';

typedef WeatherPageState = GenericScreenState<WeatherState>;

class WeatherCubit extends Cubit<ScreenState<WeatherPageState>> with BlocScreenStateMixin {
  WeatherCubit() : super(ScreenStateEmptyLoading());

  late final WeatherInteractor _interactor = Modular.get();
  late final WeatherNavigator _navigator = Modular.get();
  late final GeoLocationProvider _geoLocationManager = Modular.get();
  late final Mapper<ForecastModel, WeatherState> _forecastModelMapper = Modular.get();

  @override
  onRefresh() => _geoLocationManager
      .getLocation()
      .then((value) => _interactor.getForecast(value))
      .then(_forecastModelMapper.map)
      .then(_newState)
      .then(emitData);

  void onForecastClick(ForecastWeatherState state) => _navigator.toForecastDetails(state);

  GenericScreenState<WeatherState> _newState(WeatherState data) => GenericScreenState(data: data);
}
