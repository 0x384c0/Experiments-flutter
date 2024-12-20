import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/screen_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef ForecastDetailsPageState = GenericScreenState<Map<String?, ForecastWeatherState?>>;

class ForecastDetailsCubit extends Cubit<ScreenState<ForecastDetailsPageState>>
    with BlocScreenStateMixin {
  ForecastDetailsCubit(this._args) : super(ScreenStateEmptyLoading());

  final Map<String?, ForecastWeatherState?> _args;

  late final GeoLocationProvider _geoLocationManager = Modular.get();
  late final WeatherInteractor _interactor = Modular.get<WeatherInteractor>();
  late final Mapper<ForecastItemModel, ForecastWeatherState> _forecastItemModelMapper = Modular.get();

  @override
  onRefresh() async {
    final dateEpoch = _args.entries.first.key;
    return dateEpoch != null
        ? _geoLocationManager
            .getLocation()
            .then((value) => _interactor.getForecastItem(value, dateEpoch))
            .then(_forecastItemModelMapper.mapOptional)
            .then((value) => {dateEpoch: value})
            .then(_newState)
            .then(emitData)
        : Future.error(Exception("dateEpoch is null"));
  }

  GenericScreenState<Map<String?, ForecastWeatherState?>> _newState(Map<String?, ForecastWeatherState?> data) =>
      GenericScreenState(data: data);
}
