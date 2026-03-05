import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:injectable/injectable.dart';

import '../data/weather_state.dart';

@Injectable(as: Mapper<ForecastModel, WeatherState>)
class ForecastModelMapper extends Mapper<ForecastModel, WeatherState> {
  final Mapper<ForecastItemModel, ForecastWeatherState> _forecastItemModelMapper;
  final Mapper<ConditionModel?, ConditionState> _conditionModelMapper;

  ForecastModelMapper(this._forecastItemModelMapper, this._conditionModelMapper);

  @override
  WeatherState map(ForecastModel input) => WeatherState(
    CurrentWeatherState(
      '${input.current?.temp}°',
      '${input.current?.wind} km/h',
      '${input.current?.humidity}%',
      '${input.current?.precipitation} mm',
      _conditionModelMapper.map(input.current?.condition),
    ),
    input.forecast?.map(_forecastItemModelMapper.map) ?? [],
  );

  ConditionState getConditionState(ConditionModel? model) =>
      ConditionState(model?.text ?? '', model?.icon?.replaceAll('//', 'https://') ?? '');
}
