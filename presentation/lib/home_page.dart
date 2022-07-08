import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domain/interactor/interactor.dart';

import 'weather_cubit.dart';
import 'weather_view.dart';

//region pages
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(context.read<WeatherInteractor>()),
      child: WeatherView(),
    );
  }

// late Navigator navigator;
//
// @override
// Widget build(BuildContext context){
//   return Scaffold(
//     appBar: AppBar(title: Text('Home Page')),
//     body: Center(
//       child: Column(children: [
//         Text('This is initial page'),
//         ElevatedButton(
//           onPressed: () => navigator.toSecondPage("TEST"),
//           child: Text('Navigate to Second Page'),
//         ),
//       ],)
//     ),
//   );
// }
}