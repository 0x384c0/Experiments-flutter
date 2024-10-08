import 'dart:math';

import 'package:features_experiments_presentation/src/utils/data_generators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MasonryGridScreen extends StatelessWidget {
  const MasonryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masonry grid")),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 8, right: 8),
        child: MasonryGridView.count(
          itemCount: 100,
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: _gridItem,
        ),
      ),
    );
  }

  Widget _gridItem(BuildContext context, int index) => Card.filled(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => _onItemTap(context, index),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.album),
              title: Text("Item: $index"),
              subtitle: Text("Text: ${generateRandomString(Random(index).nextInt(100))}"),
            ),
          ),
        ),
      );

  _onItemTap(BuildContext context, int index) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tapped item: $index")),
    );
  }
}
