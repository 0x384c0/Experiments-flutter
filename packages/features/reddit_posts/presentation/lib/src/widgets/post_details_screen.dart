import 'package:common_presentation/widgets/connection_status_view.dart';
import 'package:common_presentation/widgets/screen_state/screen_state_bloc_builder.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_cubit.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_comments_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';


import 'post_details_cubit.dart';
import 'post_tile.dart';

/// Screen with post details
class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.state});

  final PostDetailsState state;

  @override
  Widget build(BuildContext context) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PostDetailsCubit(state)),
          BlocProvider(create: (_) => PostCommentsCubit(state.permalink)
          ),
        ],
        child: _buildBloc(context),
      );

  Widget _buildBloc(BuildContext context) =>
      ScreenStateBlocBuilder<PostDetailsCubit, PostDetailsState>(
        layoutBuilder: _buildScaffold,
        builder: _buildBody,
      );

  Widget _buildBody(BuildContext context, PostDetailsState data) =>
      data.postItemState != null ? _list(data.postItemState!, context) : _loadingIndicator();

  Widget _buildScaffold(PostDetailsState? data, Widget child) =>
      Scaffold(
        appBar: AppBar(title: Text(data?.postItemState?.category ?? "")),
        body: ConnectionStatusView.withChild(Center(child: child)),
      );

  Widget _list(PostItemState state, BuildContext context) {
    final PostDetailsCubit cubit = context.read();

    return Column(
      children: [
        PostTile(cubit.stateData?.postItemState ?? state, null),
        const PostCommentsView().flexible(flex: 1),
      ],
    );
  }

  Widget _loadingIndicator() => const Center(child: CircularProgressIndicator()).padding(all: 8);
}
