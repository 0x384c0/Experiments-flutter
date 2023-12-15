library presentation;

import 'package:common_presentation/ui/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/post_state.dart';
import '../widgets/post_tile.dart';
import 'posts_cubit.dart';

/// A PostsView Page.
class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(),
      child: const PostsView(),
    );
  }
}

/// View with current weather and forecast
class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final cubit = ReadContext(context).read<PostsCubit>();
    // TODO: use BlocBuilder
    cubit.refresh();
    return Scaffold(
      appBar: AppBar(title: Text(locale.reddit_posts_home_page)),
      body: Center(
        child: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
          switch (state.runtimeType) {
            case PostsStatePopulated:
              return list(context, state as PostsStatePopulated);
            case PostsStateError:
              onError((state as PostsStateError).error, context);
              return const SizedBox.shrink();
            case PostsStateEmpty:
              return const SizedBox.shrink();
          }
          throw Exception("illegal state $state");
        }),
      ),
    );
  }

  Widget list(BuildContext context, PostsStatePopulated state) {
    final cubit = ReadContext(context).read<PostsCubit>();
    var widgets = state.posts.map((e) => PostTile(e, () {
          cubit.onPostClick(e);
        }));
    return RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets.elementAt(index);
          },
        ));
  }
}
