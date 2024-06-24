import 'package:common_presentation/widgets/page_state/page_state_bloc_builder.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_tile.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) => createBlocPageStateBlocBuilder(
        getBloc: context.watch<PostCommentsCubit>,
        child: (PostCommentsPageState data) {
          final tiles = data.data.map((e) => CommentTile(e, () {}));
          return ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (context, index) => tiles.elementAt(index),
          );
        },
      );
}
