import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//modules
import 'package:presentation/home_page.dart';
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
            appBarTheme: const AppBarTheme(),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

// class AppWidget extends StatelessWidget {
//   const AppWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp.router(
//       title: 'My Smart App',
//       theme: ThemeData(primarySwatch: Colors.green),
//       routeInformationParser: Modular.routeInformationParser,
//       routerDelegate: Modular.routerDelegate,
//     );
//   }
// }