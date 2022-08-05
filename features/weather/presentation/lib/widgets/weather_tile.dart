import 'package:flutter/material.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/card_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WeatherTile extends CardTile {
  const WeatherTile(this.state ,super.onTap, {Key? key}): super(key: key);

  final CurrentWeatherState state;


  @override
  Widget buildItem(BuildContext context) {
    final locale = AppLocalizations.of(context);
    if (locale == null) return const Text("");
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
                    Text("${locale.precipitation}: ${state.precipitation}"),
                    Text("${locale.humidity}: ${state.humidity}"),
                    Text("${locale.wind}: ${state.wind}"),
                  ],
                )
              ],
            ));
  }
}
