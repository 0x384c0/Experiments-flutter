import 'package:common_presentation/ui/card_tile.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:flutter/material.dart';

class PostTile extends CardTile {
  const PostTile(this.state, super.onTap, {super.key});

  final PostItemState state;

  @override
  Widget buildItem(BuildContext context) {
    var url = state.icon?.toString();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 64,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                url?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(url!),
                      ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Wrap(
                        spacing: 4,
                        children: [
                          Text(
                            state.category,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text("•"),
                          Text(state.author),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            )));
  }
}
