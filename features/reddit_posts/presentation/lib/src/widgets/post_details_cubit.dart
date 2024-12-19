import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostDetailsCubit extends Cubit<ScreenState<PostDetailsState>> with BlocScreenStateMixin {
  PostDetailsCubit(PostDetailsState? state)
      : super(state != null ? ScreenStatePopulated(data: state) : ScreenStateEmptyLoading()) {
    refresh();
  }

  late final PostsInteractor _interactor = Modular.get();
  late final Mapper<PostModel, PostDetailsState> _postModelMapper = Modular.get();

  @override
  onRefresh() async => _interactor.getPost(permalink: stateData?.permalink).then(_postModelMapper.map).then(emitData);
}
