import 'package:common_presentation/widgets/page_state/page_state_view.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'forecast_tile.dart';
import 'weather_cubit.dart';
import 'weather_tile.dart';

/// Screen with current weather and forecast
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit()..refresh(),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WeatherCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.weather_home_page)),
      body: PageStateView.cubut(
        cubit: cubit,
        child: (data) => Center(child: _list(context, data.data)),
      ),
    );
  }

  Widget _list(BuildContext context, WeatherState state) {
    final cubit = ReadContext(context).read<WeatherCubit>();
    List<Widget> current = [WeatherTile(state.current, null)];
    List<Widget> forecast = state.forecast.map((e) => ForecastTile(e, () => cubit.onForecastClick(e))).toList();
    var widgets = current + forecast;
    return RefreshIndicator(
      onRefresh: () => cubit.refresh(),
      child: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}
