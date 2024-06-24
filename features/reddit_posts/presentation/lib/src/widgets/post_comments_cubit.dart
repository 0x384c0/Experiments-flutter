import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

typedef PostCommentsPageState = GenericPageState<Iterable<PostItemState>>;

class PostCommentsCubit extends Cubit<PageState<PostCommentsPageState>> with BlocPageStateMixin {
  PostCommentsCubit(this.permalink) : super(PageStateEmptyLoading());

  final String? permalink;

  late PostsInteractor interactor = Modular.get();
  late Mapper<PostModel, PostDetailsState> postModelMapper = Modular.get();

  @override
  onRefresh() async => interactor
      .getPost(permalink)
      .then(postModelMapper.map)
      .then((value) => value.postItemState?.comments)
      .then(_newPaginationState)
      .then(emitData);

  GenericPageState<Iterable<PostItemState>> _newPaginationState(Iterable<PostItemState>? data) =>
      GenericPageState(data: data ?? []);
}
