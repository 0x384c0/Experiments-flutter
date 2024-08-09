import 'package:common_presentation/widgets/card_tile.dart';
import 'package:features_weather_presentation/l10n/app_localizations.g.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:flutter/material.dart';

class WeatherTile extends CardTile {
  const WeatherTile(this.state, super.onTap, {super.key});

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
          const Spacer(flex: 1),
          Text(
            state.temp,
            style: const TextStyle(fontSize: 32),
          ),
          const Spacer(flex: 4),
          Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 16,
            children: [
              Text("${locale.weather_precipitation}: ${state.precipitation}"),
              Text("${locale.weather_humidity}: ${state.humidity}"),
              Text("${locale.weather_wind}: ${state.wind}"),
            ],
          )
        ],
      ),
    );
  }
}
