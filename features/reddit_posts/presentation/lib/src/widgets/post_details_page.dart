import 'package:common_presentation/widgets/connection_status_view.dart';
import 'package:common_presentation/widgets/page_state/page_state_bloc_builder.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_cubit.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_modifiers/layout/single_child_layout_widgets_modifiers.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import 'post_details_cubit.dart';
import 'post_tile.dart';

/// Screen with post details
class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.state});

  final PostDetailsState state;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PostDetailsCubit(state)..refresh()),
          BlocProvider(create: (_) => PostCommentsCubit(state.permalink)..refresh()),
        ],
        child: _PostDetailsView(),
      );
}

class _PostDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => createBlocPageStateBlocBuilder(
        layoutBuilder: _scaffoldLayoutBuilder,
        getBloc: context.read<PostDetailsCubit>,
        child: (PostDetailsState data) =>
            data.postItemState != null ? _list(data.postItemState!, context) : _loadingIndicator(),
      );

  Widget _scaffoldLayoutBuilder(PostDetailsState? data, Widget child) => Scaffold(
        appBar: AppBar(title: Text(data?.postItemState?.category ?? "")),
        body: ConnectionStatusView.withChild(Center(child: child)),
      );

  Widget _list(PostItemState state, BuildContext context) {
    final PostDetailsCubit cubit = context.read();

    return Column(
      children: [
        PostTile(cubit.stateData?.postItemState ?? state, () {}),
        const PostCommentsView().flexible(flex: 1),
      ],
    );
  }

  Widget _loadingIndicator() => const Center(child: CircularProgressIndicator()).padding(all: 8);
}
