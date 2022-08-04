import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/page_widget.dart';
import 'package:presentation/widgets/forecast_details_cubit.dart';


class ForecastDetailsPage extends StatelessWidget {
  const ForecastDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastDetailsCubit, Map<String?, ForecastWeatherState?>>(builder: (context, args) {
      final state = args.values.first;
      ReadContext(context).read<ForecastDetailsCubit>().refresh().catchError((error) => {onError(error, context)});
      return Scaffold(
        appBar: AppBar(
          title: Text(state?.date ?? "Loading"),
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
                    Text("Chance of rain: ${state.chanceOfRain}"),
                    Text("Humidity: ${state.humidity}"),
                    Text("Wind: ${state.wind}"),
                  ],
                ),
              )
            : const Center(),
      );
    });
  }
}
