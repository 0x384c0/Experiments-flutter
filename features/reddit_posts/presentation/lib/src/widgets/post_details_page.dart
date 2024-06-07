import 'package:common_presentation/widgets/page_state/page_state_view.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import 'comment_tile.dart';
import 'post_details_cubit.dart';
import 'post_tile.dart';

/// Screen with post details
class PostDetailsPage extends StatelessWidget {
  PostDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PostDetailsCubit>();
    return PageStateView.cubut(
      cubit: cubit,
      child: (data) => Scaffold(
        appBar: AppBar(title: Text(data.postItemState?.category ?? "")),
        body: Center(
          child: data.postItemState != null ? _list(data.postItemState!, context) : _loadingIndicator(),
        ),
      ),
    );
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Widget _list(PostItemState state, BuildContext context) {
    final cubit = ReadContext(context).read<PostDetailsCubit>();
    var comments = state.comments?.toList() ?? [];
    var stateAsList = [state];
    var widgets = (stateAsList + comments).map((e) {
      return e.isComment ? CommentTile(e, () {}) : PostTile(e, () {});
    });

    if (state.comments == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: cubit.refresh,
      child: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return widgets.elementAt(index);
        },
      ),
    );
  }

  Widget _loadingIndicator() => const Center(child: CircularProgressIndicator()).padding(all: 8);
}
