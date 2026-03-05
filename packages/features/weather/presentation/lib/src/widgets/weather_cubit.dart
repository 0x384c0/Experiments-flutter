import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/screen_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

typedef WeatherPageState = GenericScreenState<WeatherState>;

@injectable
class WeatherCubit extends Cubit<ScreenState<WeatherPageState>> with BlocScreenStateMixin {
  WeatherCubit(this._interactor, this._geoLocationManager, this._forecastModelMapper)
    : super(ScreenStateEmptyLoading());

  final WeatherInteractor _interactor;
  final GeoLocationProvider _geoLocationManager;
  final Mapper<ForecastModel, WeatherState> _forecastModelMapper;

  @override
  onRefresh() => _geoLocationManager
      .getLocation()
      .then((value) => _interactor.getForecast(value))
      .then(_forecastModelMapper.map)
      .then(_newState)
      .then(emitData);

  GenericScreenState<WeatherState> _newState(WeatherState data) => GenericScreenState(data: data);
}
