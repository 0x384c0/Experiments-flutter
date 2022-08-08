import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/widget_extensions.dart';
import 'package:presentation/widgets/forecast_tile.dart';
import 'package:presentation/widgets/weather_cubit.dart';
import 'package:presentation/widgets/weather_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final locale = AppLocalizations.of(context);
    if (locale == null) return const Text("");
    final cubit = ReadContext(context).read<WeatherCubit>();
    cubit.refresh();
    return Scaffold(
      appBar: AppBar(title: Text(locale.home_page)),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
          switch (state.runtimeType) {
            case WeatherStatePopulated:
              return list(context, state as WeatherStatePopulated);
            case WeatherStateError:
              onError((state as WeatherStateError).error, context);
              return const SizedBox.shrink();
            case WeatherStateEmpty:
              return const SizedBox.shrink();
          }
          throw Exception("illegal state $state");
        }),
      ),
    );
  }

  Widget list(BuildContext context, WeatherStatePopulated state) {
    final cubit = ReadContext(context).read<WeatherCubit>();
    List<Widget> current = [WeatherTile(state.current, null)];
    List<Widget> forecast = state.forecast
            .map((e) => ForecastTile(e, () {
                  cubit.onForecastClick(e);
                }))
            .toList();
    var widgets = current + forecast;
    return RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        ));
  }
}
