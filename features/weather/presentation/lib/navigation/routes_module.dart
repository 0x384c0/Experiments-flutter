import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/widgets/forecast_details_cubit.dart';
import 'package:features_weather_presentation/widgets/forecast_details_view.dart';
import 'package:features_weather_presentation/widgets/weather_page.dart';

class WeatherRoutesModule extends Module {
  static const path = '/weather';
  static const forecast = '/forecast';

  @override
  void routes(r) {
    r.child('/', child: (context) => const WeatherPage());
    r.child(
      forecast,
      child: (context) => BlocProvider(
        create: (_) => ForecastDetailsCubit({
          r.args.queryParams[Params.timeEpoch]: r.args.data is ForecastWeatherState ? r.args.data : null,
        }),
        child: const ForecastDetailsPage(),
      ),
    );
  }
}

class Params {
  static const timeEpoch = 'time_epoch';
}
