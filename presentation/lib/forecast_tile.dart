import 'package:flutter/material.dart';

import 'card_tile.dart';

class ForecastTile extends CardTile {
  const ForecastTile(super.onTap, {Key? key}): super(key: key);

  @override
  Widget buildItem() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                Text("Monday"),
                Spacer(flex: 1,),
                Text(
                  "42°",
                  style: TextStyle(fontSize: 16),
                ),
                Image.network(
                  "https://cdn.weatherapi.com/weather/64x64/day/122.png",
                  width: 32,
                  height: 32,
                ),
              ],
            ));
  }
}
