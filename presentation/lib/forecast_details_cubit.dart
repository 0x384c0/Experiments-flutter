
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/weather_state.dart';

class ForecastDetailsCubit extends Cubit<Map<String?, ForecastWeatherState?>> {
  ForecastDetailsCubit(super.initialState);
}