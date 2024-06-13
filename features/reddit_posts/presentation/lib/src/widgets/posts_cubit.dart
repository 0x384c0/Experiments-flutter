import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/mixins/cubit_alert_mixin.dart';
import 'package:common_presentation/mixins/cubit_page_state_pagination_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_state.dart';
import '../navigation/navigator.dart';

class PostsCubit extends Cubit<PageState<GenericPageState<Iterable<PostItemState>>>>
    with
        CubitPageStateMixin,
        CubitPaginationMixin<Iterable<PostItemState>, GenericPageState<Iterable<PostItemState>>>,
        CubitPageStatePaginationMixin,
        CubitPageStatePaginationIterableMixin<PostItemState, GenericPageState<Iterable<PostItemState>>>,
        CubitAlertMixin {
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
    await interactor
        .getPosts(after: null)
        .then(_saveLastAfter)
        .then(postModelMapper.map)
        .then(_newPaginationState)
        .then(emitData);
  }

  onPostTap(PostItemState state) => navigator.toPostDetails(state);

  onTopBarTap() => scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );

  //region CubitPaginationMixin
  @override
  Future<Iterable<PostItemState>> loadPage(int pageNumber) async =>
      interactor.getPosts(after: _lastAfter).then(_saveLastAfter).then(postModelMapper.map);

  // endregion

  GenericPageState<Iterable<PostItemState>> _newPaginationState(Iterable<PostItemState> data) =>
      GenericPageState(data: data);

  PostsModel _saveLastAfter(PostsModel model) {
    _lastAfter = model.after;
    return model;
  }
}
