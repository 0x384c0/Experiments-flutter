import 'package:domain/data/forecast_model.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/mapper.dart';

class ForecastModelMapper extends Mapper<ForecastModel, WeatherState> {
  @override
  WeatherState map(ForecastModel input) => WeatherState(
        CurrentWeatherState.fromModel(input),
        input.forecast?.map((e) => ForecastWeatherState.fromModel(e)).toList(),
      );
}