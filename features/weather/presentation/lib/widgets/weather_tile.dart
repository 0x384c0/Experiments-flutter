import 'package:flutter/material.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/utils/card_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WeatherTile extends CardTile {
  const WeatherTile(this.state ,super.onTap, {Key? key}): super(key: key);

  final CurrentWeatherState state;


  @override
  Widget buildItem(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Image.network(
                  state.condition.icon,
                  width: 64,
                  height: 64,
                ),
                const Spacer(flex: 1,),
                Text(
                  state.temp,
                  style: const TextStyle(fontSize: 32),
                ),
                const Spacer(flex: 4,),
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment:WrapCrossAlignment.start,
                  spacing: 16,
                  children: [
                    Text("${locale.weather_precipitation}: ${state.precipitation}"),
                    Text("${locale.weather_humidity}: ${state.humidity}"),
                    Text("${locale.weather_wind}: ${state.wind}"),
                  ],
                )
              ],
            ));
  }
}
