import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';

/// requests data from API
abstract class PostsInteractor {
  /// return list of [PostsModel] from API
  Future<List<PostModel>> getPosts();
}

class PostsInteractorImpl extends PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

  RemoteRepository remoteRepository;

  @override
  Future<List<PostModel>> getPosts() {
    return remoteRepository.getPosts();
  }
}
