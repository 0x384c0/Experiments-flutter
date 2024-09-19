import 'package:common_presentation/mixins/widget_alert_mixin.dart';
import 'package:common_presentation/widgets/connection_status_view.dart';
import 'package:common_presentation/widgets/page_state/page_screen_bloc_builder.dart';
import 'package:common_presentation/widgets/scroll_to_end_listener.dart';
import 'package:features_reddit_posts_presentation/l10n/app_localizations.g.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import 'post_tile.dart';
import 'posts_cubit.dart';

/// A PostsView Page.
class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => PostsCubit()..refresh(),
        child: Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.posts_remote_first)),
          body: const _PostsView(),
        ),
      );
}

class _PostsView extends StatelessWidget with WidgetAlertMixin {
  const _PostsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostsCubit>();
    onBuild(context, cubit);
    return createBlocPageStateBlocBuilder(
      getBloc: context.read<PostsCubit>,
      child: (PostsPageState data) => ConnectionStatusView.withChild(
        Center(child: _list(context, data.data)),
        onConnectionStatusChanged: cubit.onConnectionStatusChanged
      ),
    );
  }

  Widget _list(BuildContext context, Iterable<PostItemState> posts) {
    final postList = posts.toList();
    final cubit = context.read<PostsCubit>();
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ScrollToEndListener(
        onScrolledToEnd: cubit.loadNextPage,
        child: (controller) => CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return PostTile(
                    postList[index],
                    () => cubit.onPostTap(postList[index]),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: _pageLoadingIndicator(cubit.stateData?.paginationState?.isLoadingPage ?? false)),
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
