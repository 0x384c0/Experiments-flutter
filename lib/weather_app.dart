import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//modules
import 'package:domain/interactor/interactor.dart';
//local
import 'theme_cubit.dart';
import 'weather_app_view.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp(this._weatherInteractor, {Key? key}) : super(key: key);

  final WeatherInteractor _weatherInteractor;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherInteractor,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const WeatherAppView(),
      ),
    );
  }
}

// class AppModule extends Module {
//   @override
//   List<Bind> get binds => [
//     Bind.factory<Navigator>((i) => _NavigatorImpl())
//   ];
//
//   @override
//   List<ModularRoute> get routes => Modular.get<Navigator>().routes;
// }