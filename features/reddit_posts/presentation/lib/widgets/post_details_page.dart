import 'package:common_presentation/ui/widget_extensions.dart';
import 'package:features_reddit_posts_presentation/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/widgets/comment_tile.dart';
import 'package:features_reddit_posts_presentation/widgets/post_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'post_tile.dart';

/// Screen with post details
class PostDetailsPage extends StatelessWidget {
  PostDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(builder: (context, state) {
      switch (state.runtimeType) {
        case PostDetailsStateEmpty:
          return Scaffold(appBar: AppBar(title: Text(locale.loading)), body: Center(child: loading()));
        case PostDetailsStateEmptyComments:
          state = (state as PostDetailsStateEmptyComments);
          return Scaffold(
              appBar: AppBar(title: Text(state.postItemState.category)),
              body: Center(child: list(state.postItemState, context, true)));
        case PostDetailsStatePopulated:
          state = (state as PostDetailsStatePopulated);
          return Scaffold(
              appBar: AppBar(title: Text(state.postItemState.category)),
              body: Center(child: list(state.postItemState, context, false)));
        case PostDetailsStateError:
          onError((state as PostsStateError).error, context);
          return empty();
      }
      throw Exception("illegal state $state");
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Widget list(PostItemState? state, BuildContext context, bool isLoading) {
    final cubit = ReadContext(context).read<PostDetailsCubit>();
    var comments = state?.comments?.toList() ?? [];
    var stateAsList = (state != null) ? [state] : [];
    var widgets = (stateAsList + comments).map((e) {
      return e.isComment ? CommentTile(e, () {}) : PostTile(e, () {});
    });

    if (isLoading) {
      _refreshIndicatorKey.currentState?.show();
      cubit.refresh().catchError((error) => {onError(error, context)});
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => cubit.refresh().catchError((error) => {onError(error, context)}),
      child: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return widgets.elementAt(index);
        },
      ),
    );
  }

  Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget empty() {
    return const SizedBox.shrink();
  }
}
