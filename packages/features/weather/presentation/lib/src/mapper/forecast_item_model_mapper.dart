import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../data/weather_state.dart';
import 'condition_model_mapper.dart';

@Injectable(as: Mapper<ForecastItemModel, ForecastWeatherState>)
class ForecastItemModelMapper extends Mapper<ForecastItemModel, ForecastWeatherState> {
  final _conditionModelMapper = ConditionModelMapper();

  @override
  ForecastWeatherState map(ForecastItemModel input) => ForecastWeatherState(
        "${input.dateEpoch}",
        DateFormat("EEE, MMM d, yyyy").format(input.date ?? DateTime.now()),
        "${input.averageTemp}°",
        "${input.chanceOfRain}%",
        "${input.averageHumidity}%",
        "${input.maxWind} km/h",
        _conditionModelMapper.map(input.condition),
      );
}
