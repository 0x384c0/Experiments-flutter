import 'package:auto_route/auto_route.dart';
import 'package:common_presentation/extensions/build_context_localization.dart';
import 'package:common_presentation/widgets/screen_state/screen_state_bloc_builder.dart';
import 'package:features_weather_presentation/l10n/app_localizations.g.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_details_cubit.dart';

@RoutePage()
class ForecastDetailsScreen extends StatelessWidget {
  const ForecastDetailsScreen({super.key, required this.state});

  final ForecastWeatherState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForecastDetailsCubit({state.dateEpoch: state})..refresh(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(state.date ?? context.commonLocalization.common_loading)),
      body: ScreenStateBlocBuilder<ForecastDetailsCubit, ForecastDetailsPageState>(
        builder: (context, data) => Center(child: _list(context, data.data.values.first!)),
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
