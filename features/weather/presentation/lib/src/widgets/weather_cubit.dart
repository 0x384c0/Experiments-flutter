import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/weather_state.dart';
import '../navigation/navigator.dart';
import '../utils/geo_location_provider.dart';

typedef WeatherPageState = GenericPageState<WeatherState>;

class WeatherCubit extends Cubit<PageState<WeatherPageState>> with BlocPageStateMixin {
  WeatherCubit() : super(PageStateEmptyLoading());

  late WeatherInteractor interactor = Modular.get();
  late WeatherNavigator navigator = Modular.get();
  late GeoLocationProvider geoLocationManager = Modular.get();
  late Mapper<ForecastModel, WeatherState> forecastModelMapper = Modular.get();

  @override
  onRefresh() => geoLocationManager
      .getLocation()
      .then((value) => interactor.getForecast(value))
      .then(forecastModelMapper.map)
      .then(_newState)
      .then(emitData);

  void onForecastClick(ForecastWeatherState state) => navigator.toForecastDetails(state);

  GenericPageState<WeatherState> _newState(WeatherState data) => GenericPageState(data: data);
}
