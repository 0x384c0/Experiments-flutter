import 'package:common_presentation/widgets/screen_state/screen_state_bloc_builder.dart';
import 'package:common_presentation/widgets/scroll_to_end_listener.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import 'comment_tile.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) => ScreenStateBlocBuilder<PostCommentsCubit, PostCommentsPageState>(
        builder: (context, data) {
          final postList = data.data.toList();
          return ScrollToEndListener(
            onScrolledToEnd: context.read<PostCommentsCubit>().loadNextPage,
            child: (controller) => CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) => CommentTile(postList[index], null),
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
}
