import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostDetailsCubit extends Cubit<PageState<PostDetailsState>> with BlocPageStateMixin {
  PostDetailsCubit(PostDetailsState? state)
      : super(state != null ? PageStatePopulated(data: state) : PageStateEmptyLoading());

  late final PostsInteractor _interactor = Modular.get();
  late final Mapper<PostModel, PostDetailsState> _postModelMapper = Modular.get();

  @override
  onRefresh() async => _interactor.getPost(permalink:stateData?.permalink).then(_postModelMapper.map).then(emitData);
}
