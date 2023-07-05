import 'package:common_presentation/ui/widget_extensions.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/widgets/comment_tile.dart';
import 'package:features_reddit_posts_presentation/widgets/post_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'post_tile.dart';

/// Screen with post details
class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostDetailsCubit, Map<String?, PostItemState?>>(builder: (context, args) {
      final state = args.values.first;
      final cubit = ReadContext(context).read<PostDetailsCubit>();
      cubit.refresh().catchError((error) => {onError(error, context)});
      return Scaffold(
          appBar: AppBar(
            title: Text(state?.category ?? locale.loading),
          ),
          body: Center(child: state != null ? list(state, cubit) : loading()));
    });
  }

  Widget list(PostItemState state, PostDetailsCubit cubit) {
    var widgets = ([state] + (state.comments ?? [])).map((e) {
      return e.isComment ? CommentTile(e, () {}) : PostTile(e, () {});
    });
    return RefreshIndicator(
      onRefresh: () => cubit.refresh(),
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
}
