import 'package:common_presentation/extensions/build_context.dart';
import 'package:common_presentation/widgets/page_state/page_state_bloc_builder.dart';
import 'package:features_weather_presentation/l10n/app_localizations.g.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_details_cubit.dart';

class ForecastDetailsPage extends StatelessWidget {
  const ForecastDetailsPage({super.key, required this.args});

  final Map<String?, ForecastWeatherState?> args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForecastDetailsCubit(args)..refresh(),
      child: _ForecastDetails(args),
    );
  }
}

class _ForecastDetails extends StatelessWidget {
  const _ForecastDetails(this.args);

  final Map<String?, ForecastWeatherState?> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(args.values.firstOrNull?.date ?? context.commonLocalization!.common_loading)),
      body: createBlocPageStateBlocBuilder(
        getBloc: context.watch<ForecastDetailsCubit>,
        child: (ForecastDetailsPageState data) => Center(child: _list(context, data.data.values.first!)),
      ),
    );
  }

  Widget _list(BuildContext context, ForecastWeatherState state) {
    final locale = AppLocalizations.of(context)!;
    return Wrap(
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
    );
  }
}
