import 'package:flutter/material.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/card_tile.dart';


class WeatherTile extends CardTile {
  const WeatherTile(this.state ,super.onTap, {Key? key}): super(key: key);

  final CurrentWeatherState state;


  @override
  Widget buildItem() {
    return Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Image.network(
                  state.condition.icon,
                  width: 64,
                  height: 64,
                ),
                Spacer(flex: 1,),
                Text(
                  state.temp,
                  style: TextStyle(fontSize: 32),
                ),
                Spacer(flex: 4,),
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment:WrapCrossAlignment.start,
                  spacing: 16,
                  children: [
                    Text("Precipitation: ${state.precipitation}"),
                    Text("Humidity: ${state.humidity}"),
                    Text("Wind: ${state.wind}"),
                  ],
                )
              ],
            ));
  }
}
