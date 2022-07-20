import 'package:flutter/material.dart';
import 'package:presentation/weather_state.dart';

import 'card_tile.dart';

class ForecastTile extends CardTile {
  const ForecastTile(this.state ,super.onTap, {Key? key}): super(key: key);

  final ForecastWeatherState state;

  @override
  Widget buildItem() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                Text(state.date),
                Spacer(flex: 1,),
                Text(
                  state.temp,
                  style: TextStyle(fontSize: 16),
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
