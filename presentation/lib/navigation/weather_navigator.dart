import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/weather_page.dart';

import '../forecast_details_cubit.dart';
import '../forecast_details_view.dart';

abstract class WeatherNavigator {
  toForecastDetails(ForecastWeatherState state);

  back();
}

class _WeatherNavigatorImpl implements WeatherNavigator {
  final BuildContext context;

  _WeatherNavigatorImpl(this.context);

  @override
  toForecastDetails(ForecastWeatherState state) {
    Modular.to.pushNamed('/forecast?time_epoch=${state.dateEpoch}', arguments: state);
  }

  @override
  back() {
    Modular.to.pop();
  }
}

WeatherNavigator provideWeatherNavigator(BuildContext context) {
  return _WeatherNavigatorImpl(context);
}

List<ModularRoute> getWeatherRoutes(){
  return [
    ChildRoute('/', child: (context, args) => const WeatherPage()),
    ChildRoute('/forecast', child: (context, args) => BlocProvider.value(
      value: ForecastDetailsCubit({args.queryParams["time_epoch"] : args.data is ForecastWeatherState ? args.data : null}),
      child: const ForecastDetailsPage(),
    ),),
  ];
}