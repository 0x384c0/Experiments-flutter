import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/widgets/forecast_details_cubit.dart';
import 'package:presentation/widgets/forecast_details_view.dart';
import 'package:presentation/widgets/weather_page.dart';

class PresentationRoutesModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const WeatherPage()),
        ChildRoute(
          '/forecast',
          child: (context, args) => BlocProvider.value(
            value: ForecastDetailsCubit({
              args.queryParams["time_epoch"]:
                  args.data is ForecastWeatherState ? args.data : null
            }),
            child: const ForecastDetailsPage(),
          ),
        ),
      ];
}
