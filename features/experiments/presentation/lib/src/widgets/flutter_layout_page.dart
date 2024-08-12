import 'package:features_experiments_presentation/src/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FlutterLayoutPage extends StatelessWidget {
  FlutterLayoutPage({super.key});

  late final ExperimentsNavigator _navigator = Modular.get();

  @override
  Widget build(BuildContext context) =>
      ListView(
        children: [
          ListTile(
            title: Text("Masonry grid"),
            onTap: _navigator.toMasonryGrid,
          ),
        ],
      );
}
