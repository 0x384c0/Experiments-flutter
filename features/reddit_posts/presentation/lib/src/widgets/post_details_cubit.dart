import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit(super.initialState);

  late PostsInteractor interactor = Modular.get();
  late Mapper<PostModel, PostDetailsState> postModelMapper = Modular.get();

  Future<void> refresh() async {
    return interactor.getPost(state.permalink).then(postModelMapper.map).catchError(catchError).then(emit);
  }

  PostDetailsState catchError(Object e) => PostDetailsStateError(state.permalink, e);
}
