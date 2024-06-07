import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/data/page_state/page_state.dart';
import 'package:common_presentation/data/page_state/page_state_cubit.dart';
import 'package:common_presentation/mixins/cubit_with_pagination.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_state.dart';
import '../navigation/navigator.dart';

class PostsCubit extends PageStateCubit<Iterable<PostItemState>>
    with CubitWithPagination<PageState<Iterable<PostItemState>>, Iterable<PostItemState>> {
  late PostsInteractor interactor = Modular.get();
  late PostsNavigator navigator = Modular.get();
  late Mapper<PostsModel, Iterable<PostItemState>> postModelMapper = Modular.get();

  String? _lastAfter;

  @override
  onRefresh() async {
    _lastAfter = null;
    onBeforeFirstPageLoad();
    await interactor.getPosts(after: null).then(_saveAfter).then(postModelMapper.map).then(emitData);
  }

  onPostClick(PostItemState state) => navigator.toPostDetails(state);

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
