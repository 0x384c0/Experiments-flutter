import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/usecases/interactor.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/navigation/navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateEmpty());

  late PostsInteractor interactor = Modular.get();
  late Navigator navigator = Modular.get();
  late Mapper<List<PostModel>, PostsState> postModelMapper = Modular.get();

  Future<void> refresh() async {
    return interactor.getPosts().then(postModelMapper.map).catchError(catchError).then(emit);
  }

  void onPostClick(PostItemState state) {
    navigator.toPostDetails(state);
  }

  PostsState catchError(Object e) => PostsStateError(e);
}
