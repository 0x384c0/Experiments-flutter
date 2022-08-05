import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/widget_extensions.dart';
import 'package:presentation/widgets/forecast_details_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForecastDetailsPage extends StatelessWidget {
  const ForecastDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    if (locale == null) return const Text("");
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
                    Text("${locale.chance_of_rain}: ${state.chanceOfRain}"),
                    Text("${locale.humidity}: ${state.humidity}"),
                    Text("${locale.wind}: ${state.wind}"),
                  ],
                ),
              )
            : const Center(),
      );
    });
  }
}
