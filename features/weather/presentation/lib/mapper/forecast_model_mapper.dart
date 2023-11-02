import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/data/weather_model.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:common_presentation/data/mapper.dart';

import 'condition_model_mapper.dart';
import 'forecast_item_model_mapper.dart';

class ForecastModelMapper extends Mapper<ForecastModel, WeatherState> {
  var forecastItemModelMapper = ForecastItemModelMapper();
  var conditionModelMapper = ConditionModelMapper();

  @override
  WeatherStatePopulated map(ForecastModel input) {
    var condition = input.current?.condition;
    return WeatherStatePopulated(
      CurrentWeatherState(
        "${input.current?.temp}°",
        "${input.current?.wind} km/h",
        "${input.current?.humidity}%",
        "${input.current?.precipitation} mm",
        conditionModelMapper.map(condition),
      ),
      input.forecast?.map(forecastItemModelMapper.map) ?? [],
    );
  }

  ConditionState getConditionState(ConditionModel? model) =>
      ConditionState(
        model?.text ?? "",
        model?.icon?.replaceAll("//", "https://") ?? "",
      );
}