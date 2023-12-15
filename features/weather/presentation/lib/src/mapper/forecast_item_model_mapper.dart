import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/data/forecast_model.dart';
import '../data/weather_state.dart';
import 'package:intl/intl.dart';

import 'condition_model_mapper.dart';

class ForecastItemModelMapper extends Mapper<ForecastItemModel, ForecastWeatherState> {
  var conditionModelMapper = ConditionModelMapper();

  @override
  ForecastWeatherState map(ForecastItemModel input) => ForecastWeatherState(
        "${input.dateEpoch}",
        DateFormat("EEE, MMM d, yyyy").format(input.date ?? DateTime.now()),
        "${input.averageTemp}°",
        "${input.chanceOfRain}%",
        "${input.averageHumidity}%",
        "${input.maxWind} km/h",
        conditionModelMapper.map(input.condition),
      );
}
