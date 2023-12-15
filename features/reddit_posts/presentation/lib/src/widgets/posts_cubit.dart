import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_state.dart';
import '../navigation/navigator.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateEmpty());

  late PostsInteractor interactor = Modular.get();
  late PostsNavigator navigator = Modular.get();
  late Mapper<Iterable<PostModel>, PostsState> postModelMapper = Modular.get();

  Future<void> refresh() async {
    return interactor.getPosts().then(postModelMapper.map).catchError(catchError).then(emit);
  }

  void onPostClick(PostItemState state) {
    navigator.toPostDetails(state);
  }

  PostsState catchError(Object e) => PostsStateError(e);
}
