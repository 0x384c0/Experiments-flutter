import 'package:common_presentation/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:widgets_modifiers/layout/single_child_layout_widgets_modifiers.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import '../data/post_state.dart';

class PostTile extends CardTile {
  const PostTile(this.state, super.onTap, {super.key});

  final PostItemState state;

  @override
  Widget buildItem(BuildContext context) {
    var url = state.icon?.toString();
    return Row(
      children: [
        url?.isEmpty ?? true
            ? const SizedBox.shrink()
            : SizedBox(
                width: 64,
                height: 64,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url!,
                  imageErrorBuilder: _imageError,
                  fit: BoxFit.fitHeight,
                ),
              ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  state.category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(" • "),
                Expanded(
                  child: Text(
                    state.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ).flexible(flex: 1),
      ],
    ).padding(all: url?.isEmpty ?? true ? 8 : 0);
  }

  Widget _imageError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) =>
      const Icon(Icons.image);
}
