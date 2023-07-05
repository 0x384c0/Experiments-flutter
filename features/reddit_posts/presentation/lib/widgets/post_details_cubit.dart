import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/usecases/interactor.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostDetailsCubit extends Cubit<Map<String?, PostItemState?>> {
  PostDetailsCubit(super.initialState);

  late PostsInteractor interactor = Modular.get();
  late Mapper<PostModel, PostItemState> postModelMapper = Modular.get();

  Future<void> refresh() async {
    final permalink = state.entries.first.key;
    return permalink != null
        ? interactor
        .getPost(permalink)
        .then(postModelMapper.map)
        .then((value) => emit({permalink: value}))
        : Future.error(Exception("permalink is null"));
  }
}
