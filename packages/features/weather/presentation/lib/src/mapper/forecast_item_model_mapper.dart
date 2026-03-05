import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../data/weather_state.dart';

@Injectable(as: Mapper<ForecastItemModel, ForecastWeatherState>)
class ForecastItemModelMapper extends Mapper<ForecastItemModel, ForecastWeatherState> {
  final Mapper<ConditionModel?, ConditionState> _conditionModelMapper;

  ForecastItemModelMapper(this._conditionModelMapper);

  @override
  ForecastWeatherState map(ForecastItemModel input) => ForecastWeatherState(
    '${input.dateEpoch}',
    DateFormat('EEE, MMM d, yyyy').format(input.date ?? DateTime.now()),
    '${input.averageTemp}°',
    '${input.chanceOfRain}%',
    '${input.averageHumidity}%',
    '${input.maxWind} km/h',
    _conditionModelMapper.map(input.condition),
  );
}
