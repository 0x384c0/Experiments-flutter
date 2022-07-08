import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/weather_cubit.dart';
import 'package:presentation/weather_state.dart';

import 'forecast_tile.dart';
import 'weather_tile.dart';

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<WeatherCubit>().refresh();
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
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
    List<Widget>  forecast = state.forecast
            ?.map((e) => ForecastTile(() {
                  debugPrint("ForecastTile TAP");
                }))
            .toList() ??
        [];
    var widgets = current + forecast;
    return RefreshIndicator(
        onRefresh: () => context.read<WeatherCubit>().refresh(),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        ));
  }
}

// class SecondPage extends StatelessWidget {
//   SecondPage(this.name, {Key? key}) : super(key: key);
//
//   final String name;
//   late Navigator navigator;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Second Page $name')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => navigator.back(),
//           child: Text('Back to Home'),
//         ),
//       ),
//     );
//   }
// }
