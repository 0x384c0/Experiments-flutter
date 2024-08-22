import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';
import 'package:common_presentation/widgets/page_state/page_state_bloc_builder.dart';
import 'package:common_presentation/widgets/scroll_to_end_listener.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_tile.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) => createBlocPageStateBlocBuilder(
        getBloc: context.read<PostCommentsCubit>,
        child: (PostCommentsPageState data) {
          final tiles = _mapDataToTiles(data);
          return ScrollToEndListener(
            onScrolledToEnd: context.read<PostCommentsCubit>().loadNextPage,
            child: (controller) => CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: tiles.length,
                    itemBuilder: (context, index) => tiles.elementAt(index),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _pageLoadingIndicator(
                    context.read<PostCommentsCubit>().stateData?.paginationState?.isLoadingPage ?? false,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget _pageLoadingIndicator(bool isLoadingPage) => Visibility(
        visible: isLoadingPage,
        child: const Center(child: CircularProgressIndicator()).padding(all: 8),
      );

  Iterable<Widget> _mapDataToTiles(PostCommentsPageState data) => data.data.map((e) => CommentTile(e, () {}));
}
