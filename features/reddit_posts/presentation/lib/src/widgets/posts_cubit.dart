import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/mixins/cubit_alert_mixin.dart';
import 'package:common_presentation/mixins/cubit_screen_state_pagination_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/screen_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef PostsPageState = GenericScreenState<Iterable<PostItemState>>;

class PostsCubit extends Cubit<ScreenState<PostsPageState>>
    with
        BlocScreenStateMixin,
        CubitPaginationMixin<Iterable<PostItemState>, GenericScreenState<Iterable<PostItemState>>>,
        CubitScreenStatePaginationMixin,
        CubitScreenStatePaginationIterableMixin<PostItemState, GenericScreenState<Iterable<PostItemState>>>,
        CubitAlertMixin {
  PostsCubit() : super(ScreenStateEmptyLoading()){
    refresh();
  }

  late final PostsInteractor _interactor = Modular.get();
  late final PostsNavigator _navigator = Modular.get();
  late final Mapper<PostsModel, Iterable<PostItemState>> _postModelMapper = Modular.get();

  String? _lastAfter;

  @override
  onRefresh() async {
    _lastAfter = null;
    onBeforeFirstPageLoad();
    await _interactor
        .getPosts(after: null)
        .then(_saveLastAfter)
        .then(_postModelMapper.map)
        .then(_newPaginationState)
        .then(emitData);
  }

  onPostTap(PostItemState state) => _navigator.toPostDetails(state);

  //region CubitPaginationMixin
  @override
  Future<Iterable<PostItemState>> loadPage(int pageNumber) => _interactor
      .getPosts(
        after: _lastAfter,
      )
      .then(_saveLastAfter)
      .then(_postModelMapper.map);

  @override
  Iterable<PostItemState>? getPagesIterable() => stateData?.data;

  // endregion

  GenericScreenState<Iterable<PostItemState>> _newPaginationState(Iterable<PostItemState> data) =>
      GenericScreenState(data: data);

  PostsModel _saveLastAfter(PostsModel model) {
    _lastAfter = model.after;
    return model;
  }
}
