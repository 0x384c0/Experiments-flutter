library presentation;

import 'package:common_presentation/widgets/page_state/page_state_view.dart';
import 'package:common_presentation/widgets/scroll_to_end_listener.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import 'post_tile.dart';
import 'posts_cubit.dart';

/// A PostsView Page.
class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit()..refresh(),
      child: const _PostsView(),
    );
  }
}

class _PostsView extends StatelessWidget {
  const _PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PostsCubit>();
    return PageStateView.cubut(
      cubit: cubit,
      child: (data) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.reddit_posts_home_page).onTap(cubit.onTopBarTap)),
        body: Center(child: _list(context, data)),
      ),
    );
  }

  Widget _list(BuildContext context, Iterable<PostItemState> posts) {
    final cubit = context.watch<PostsCubit>();
    var widgets = posts.map((e) => PostTile(e, () => cubit.onPostTap(e)));
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ScrollToEndListener(
        controller: cubit.scrollController,
        onScrolledToEnd: cubit.loadNextPage,
        child: (controller) => CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList.builder(
                itemCount: widgets.length,
                itemBuilder: (context, index) => widgets.elementAt(index),
              ),
            ),
            SliverToBoxAdapter(child: _pageLoadingIndicator(cubit.state.paginationState?.isLoadingPage ?? false)),
          ],
        ),
      ),
    );
  }

  Widget _pageLoadingIndicator(bool isLoadingPage) => Visibility(
        visible: isLoadingPage,
        child: const Center(child: CircularProgressIndicator()).padding(all: 8),
      );
}
