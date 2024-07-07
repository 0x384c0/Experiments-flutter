import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef ForecastDetailsPageState = GenericPageState<Map<String?, ForecastWeatherState?>>;

class ForecastDetailsCubit extends Cubit<PageState<ForecastDetailsPageState>>
    with BlocPageStateMixin {
  ForecastDetailsCubit(this._args) : super(PageStateEmptyLoading());

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

  GenericPageState<Map<String?, ForecastWeatherState?>> _newState(Map<String?, ForecastWeatherState?> data) =>
      GenericPageState(data: data);
}
