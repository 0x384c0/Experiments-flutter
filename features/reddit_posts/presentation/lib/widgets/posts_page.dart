library presentation;

import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    cubit.refresh();
    return Scaffold(
      appBar: AppBar(title: Text(locale.weather_home_page)),
      body: Center(
        child: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
          switch (state.runtimeType) {
            case PostsStatePopulated:
              return list(context, state as PostsStatePopulated);
            case PostsStateError:
              // onError((state as PostsStateError).error, context); // TODO: reuse WidgetExtensions
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
    List<Widget> widgets = state.posts
        .map((e) => PostTile(e))
    //     .map((e) => PostTile(e, () {
    //   cubit.onPostClick(e);
    // }))
        .toList();
    return RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        ));
  }
}