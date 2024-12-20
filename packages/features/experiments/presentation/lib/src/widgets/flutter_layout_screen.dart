import 'package:features_experiments_presentation/src/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FlutterLayoutScreen extends StatelessWidget {
  const FlutterLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final ExperimentsNavigator navigator = Modular.get();
    return ListView(
      children: [
        ListTile(
          title: Text("Masonry grid"),
          onTap: navigator.toMasonryGrid,
        ),
        ListTile(
          title: Text("Widgets"),
          onTap: navigator.toWidgets,
        ),
      ],
    );
  }
}
