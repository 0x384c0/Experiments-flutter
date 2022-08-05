import 'package:domain/data/forecast_model.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/mapper.dart';

class ForecastItemModelMapper extends Mapper<ForecastItemModel, ForecastWeatherState> {
  @override
  ForecastWeatherState map(ForecastItemModel input) => ForecastWeatherState.fromModel(input);
}
