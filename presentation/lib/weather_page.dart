import 'package:domain/interactor/interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/weather_cubit.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/navigation/weather_navigator.dart';

import 'forecast_tile.dart';
import 'weather_tile.dart';

//region pages
class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadContext(context).read<WeatherCubit>().refresh();
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')), //TODO: localize all strings
      body: Center(
        child:
            BlocBuilder<WeatherCubit, WeatherState?>(builder: (context, state) {
          return state == null ? Text("Loading") : list(context, state);
        }),
      ),
    );
  }

  Widget list(BuildContext context, WeatherState state) {
    List<Widget> current = [WeatherTile(state.current!, null)];
    List<Widget> forecast = state.forecast
            ?.map((e) => ForecastTile(e, () {
                  ReadContext(context).read<WeatherCubit>().onForecastClick(e);
                }))
            .toList() ??
        [];
    var widgets = current + forecast;
    return RefreshIndicator(
        onRefresh: () => ReadContext(context).read<WeatherCubit>().refresh(),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        ));
  }
}
