import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/utils/mapper.dart';

class ForecastModelMapper extends Mapper<ForecastModel, WeatherState> {
  @override
  WeatherStatePopulated map(ForecastModel input) => WeatherStatePopulated(
        CurrentWeatherState.fromModel(input),
        input.forecast?.map((e) => ForecastWeatherState.fromModel(e)).toList() ?? [],
      );
}
