import 'package:auto_route/auto_route.dart';
import 'package:features_experiments_presentation/src/navigation/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FlutterLayoutScreen extends StatelessWidget {
  const FlutterLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context); // TODO: get from DI
    return ListView(
      children: [
        ListTile(title: Text("Masonry grid"), onTap: () => router.push(MasonryGridRoute())),
        ListTile(title: Text("Widgets"), onTap: () => router.push(WidgetsRoute())),
      ],
    );
  }
}
