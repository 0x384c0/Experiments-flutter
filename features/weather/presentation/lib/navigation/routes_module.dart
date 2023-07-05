import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/widgets/forecast_details_cubit.dart';
import 'package:features_weather_presentation/widgets/forecast_details_view.dart';
import 'package:features_weather_presentation/widgets/weather_page.dart';

class RoutesModule extends Module {
  static const path = '/weather';
  static const forecast = '/forecast';

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const WeatherPage()),
        ChildRoute(
          forecast,
          child: (context, args) => BlocProvider.value(
            value: ForecastDetailsCubit(
                {args.queryParams[Params.timeEpoch]: args.data is ForecastWeatherState ? args.data : null}),
            child: const ForecastDetailsPage(),
          ),
        ),
      ];
}

class Params {
  static const timeEpoch = 'time_epoch';
}
