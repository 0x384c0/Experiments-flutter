import 'package:common_presentation/ui/card_tile.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:flutter/material.dart';

class PostTile extends CardTile {
  const PostTile(this.state, super.onTap, {super.key});

  final PostItemState state;

  @override
  Widget buildItem(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Row(
          children: [
            Text(state.author),
            const Spacer(
              flex: 1,
            ),
            Text(
              state.title,
              style: const TextStyle(fontSize: 16),
            ),
            Image.network(
              state.icon,
              width: 32,
              height: 32,
            ),
          ],
        ));
  }
}
