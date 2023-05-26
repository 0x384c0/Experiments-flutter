import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/utils/widget_extensions.dart';
import 'package:features_weather_presentation/widgets/forecast_details_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Screen with forecast detail for specific date
class ForecastDetailsPage extends StatelessWidget {
  const ForecastDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<ForecastDetailsCubit, Map<String?, ForecastWeatherState?>>(builder: (context, args) {
      final state = args.values.first;
      ReadContext(context).read<ForecastDetailsCubit>().refresh().catchError((error) => {onError(error, context)});
      return Scaffold(
        appBar: AppBar(
          title: Text(state?.date ?? locale.loading),
        ),
        body: state != null
            ? Center(
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 16,
                  children: [
                    Image.network(
                      state.condition.icon,
                      width: 64,
                      height: 64,
                    ),
                    Text("${locale.weather_chance_of_rain}: ${state.chanceOfRain}"),
                    Text("${locale.weather_humidity}: ${state.humidity}"),
                    Text("${locale.weather_wind}: ${state.wind}"),
                  ],
                ),
              )
            : const Center(),
      );
    });
  }
}
