import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_state.dart';
import '../navigation/navigator.dart';

class PostsCubit extends Cubit<PageState<Iterable<PostItemState>>>
    with
        CubitPageStateMixin,
        CubitPaginationMixin<PageState<Iterable<PostItemState>>, Iterable<PostItemState>> {
  PostsCubit() : super(PageStateEmptyLoading());

  late PostsInteractor interactor = Modular.get();
  late PostsNavigator navigator = Modular.get();
  late Mapper<PostsModel, Iterable<PostItemState>> postModelMapper = Modular.get();

  final scrollController = ScrollController();

  String? _lastAfter;

  @override
  onRefresh() async {
    _lastAfter = null;
    onBeforeFirstPageLoad();
    await interactor.getPosts(after: null).then(_saveAfter).then(postModelMapper.map).then(emitData);
  }

  onPostTap(PostItemState state) => navigator.toPostDetails(state);

  onTopBarTap() => scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );

  @override
  emitWithNewPage(Iterable<PostItemState> nextPageData) => emitData([
        ...stateData ?? [],
        ...nextPageData,
      ]);

  @override
  bool get isCanLoadPages => stateData?.isNotEmpty == true;

  @override
  bool isLastPage(Iterable<PostItemState> data) => data.isEmpty;

  @override
  Future<Iterable<PostItemState>> loadPage(int pageNumber) async =>
      interactor.getPosts(after: _lastAfter).then(_saveAfter).then(postModelMapper.map);

  PostsModel _saveAfter(PostsModel model) {
    _lastAfter = model.after;
    return model;
  }
}
