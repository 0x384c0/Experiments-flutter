import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForecastDetailsCubit extends Cubit<PageState<GenericPageState<Map<String?, ForecastWeatherState?>>>>
    with CubitPageStateMixin {
  ForecastDetailsCubit(this.args) : super(PageStateEmptyLoading());

  final Map<String?, ForecastWeatherState?> args;

  late GeoLocationProvider geoLocationManager = Modular.get();
  late WeatherInteractor interactor = Modular.get<WeatherInteractor>();
  late Mapper<ForecastItemModel, ForecastWeatherState> forecastItemModelMapper = Modular.get();

  @override
  onRefresh() async {
    final dateEpoch = args.entries.first.key;
    return dateEpoch != null
        ? geoLocationManager
            .getLocation()
            .then((value) => interactor.getForecastItem(value, dateEpoch))
            .then(forecastItemModelMapper.mapOptional)
            .then((value) => {dateEpoch: value})
            .then(_newState)
            .then(emitData)
        : Future.error(Exception("dateEpoch is null"));
  }

  GenericPageState<Map<String?, ForecastWeatherState?>> _newState(Map<String?, ForecastWeatherState?> data) =>
      GenericPageState(data: data);
}
