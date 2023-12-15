import 'package:common_presentation/ui/card_tile.dart';
import 'package:flutter/material.dart';

import '../data/post_state.dart';

class CommentTile extends CardTile {
  const CommentTile(this.state, super.onTap, {super.key});

  final PostItemState state;

  @override
  Widget buildItem(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.author),
              const SizedBox(height: 8),
              Text(
                state.title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
