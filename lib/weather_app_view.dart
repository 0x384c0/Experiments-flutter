import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//modules
import 'package:presentation/weather_page.dart';

//local
import 'theme_cubit.dart';

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
            theme: ThemeData(
              primaryColor: color,
              scaffoldBackgroundColor: Colors.grey[100],
              appBarTheme: const AppBarTheme(),
            ),
              home: const WeatherPage(),
            );
      },
    );
  }
}
