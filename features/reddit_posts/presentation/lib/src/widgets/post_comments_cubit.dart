import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/mixins/cubit_page_state_pagination_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef PostCommentsPageState = GenericPageState<Iterable<PostItemState>>;

class PostCommentsCubit extends Cubit<PageState<PostCommentsPageState>>
    with
        BlocPageStateMixin,
        CubitPaginationMixin<Iterable<PostItemState>, GenericPageState<Iterable<PostItemState>>>,
        CubitPageStatePaginationMixin,
        CubitPageStatePaginationIterableMixin<PostItemState, GenericPageState<Iterable<PostItemState>>> {
  PostCommentsCubit(this._permalink) : super(PageStateEmptyLoading());

  final String? _permalink;

  late final PostsInteractor _interactor = Modular.get();
  late final Mapper<PostModel, PostDetailsState> _postModelToPostDetailsStateMapper = Modular.get();
  late final Mapper<PostModel, PostItemState> _postModelToPostItemStateMapper = Modular.get();

  @override
  onRefresh() async {
    onBeforeFirstPageLoad();
    await _interactor
        .getPost(permalink: _permalink)
        .then(_storeMoreModel)
        .then(_postModelToPostDetailsStateMapper.map)
        .then((value) => value.postItemState?.comments)
        .then(_newPaginationState)
        .then(emitData);
  }

  GenericPageState<Iterable<PostItemState>> _newPaginationState(Iterable<PostItemState>? data) =>
      GenericPageState(data: data ?? []);

  MoreModel? _moreModel;

  PostModel _storeMoreModel(PostModel postModel) {
    _moreModel = postModel.moreModel;
    return postModel;
  }

//region CubitPaginationMixin
  @override
  Future<Iterable<PostItemState>> loadPage(int pageNumber) => _interactor
      .getMoreChildren(page: pageNumber, moreModel: _moreModel)
      .then(_postModelToPostItemStateMapper.mapIterable);

  @override
  Iterable<PostItemState>? getPagesIterable() => stateData?.data;

// endregion
}
