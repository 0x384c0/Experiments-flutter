import 'package:auto_route/auto_route.dart';
import 'package:common_presentation/widgets/screen_state/screen_state_bloc_builder.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

import 'forecast_tile.dart';
import 'weather_cubit.dart';
import 'weather_tile.dart';

/// Screen with current weather and forecast
@RoutePage()
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(create: (_) => WeatherCubit()..refresh(), child: _buildBody(context));

  Widget _buildBody(BuildContext context) => ScreenStateBlocBuilder<WeatherCubit, WeatherPageState>(
    builder: (context, data) => Center(child: _list(context, data.data)),
  );

  Widget _list(BuildContext context, WeatherState state) {
    final router = AutoRouter.of(context);
    final WeatherCubit cubit = ReadContext(context).read();
    var widgets = [
      WeatherTile(state.current, null),
      ...state.forecast.map((e) => ForecastTile(e, () => router.push(ForecastDetailsRoute(state: e)))),
    ].separator(SizedBox(height: 8));
    return RefreshIndicator(
      onRefresh: () => cubit.refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}
