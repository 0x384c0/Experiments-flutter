import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:common_presentation/data/mapper.dart';

class ForecastItemModelMapper extends Mapper<ForecastItemModel, ForecastWeatherState> {
  @override
  ForecastWeatherState map(ForecastItemModel input) => ForecastWeatherState.fromModel(input);
}
