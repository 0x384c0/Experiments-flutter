import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/data/weather_state.dart';

import '../forecast_details_cubit.dart';
import '../forecast_details_view.dart';

abstract class WeatherNavigator {
  // TODO: dont pass BuildContext
  toForecastDetails(ForecastWeatherState state);

  back();
}

class _WeatherNavigatorImpl implements WeatherNavigator {
  final BuildContext context;

  _WeatherNavigatorImpl(this.context);

  @override
  toForecastDetails(ForecastWeatherState state) {
    Navigator.of(context).push<void>(MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: ForecastDetailsCubit(state),
        child: const ForecastDetailsPage(),
      ),
    ));
  }

  @override
  back() {
    Navigator.of(context).pop();
  }
}


WeatherNavigator provideWeatherNavigator(BuildContext context){
  return _WeatherNavigatorImpl(context);
}