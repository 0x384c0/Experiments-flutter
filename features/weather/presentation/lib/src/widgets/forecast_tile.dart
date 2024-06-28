import 'package:common_presentation/widgets/card_tile.dart';
import '../data/weather_state.dart';
import 'package:flutter/material.dart';

class ForecastTile extends CardTile {
  const ForecastTile(this.state ,super.onTap, {super.key});

  final ForecastWeatherState state;

  @override
  Widget buildItem(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                Text(state.date),
                const Spacer(flex: 1,),
                Text(
                  state.temp,
                  style: const TextStyle(fontSize: 16),
                ),
                Image.network(
                  state.condition.icon,
                  width: 32,
                  height: 32,
                ),
              ],
            ));
  }
}
