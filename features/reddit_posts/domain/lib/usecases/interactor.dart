import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';

/// requests data from API
abstract class PostsInteractor {
  /// return list of [PostsModel] from API
  Future<Iterable<PostModel>> getPosts();
  /// return single [PostsModel] with comments from API
  Future<PostModel> getPost(String permalink);
}

class PostsInteractorImpl extends PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

  RemoteRepository remoteRepository;

  @override
  Future<Iterable<PostModel>> getPosts() {
    return remoteRepository.getPosts();
  }

  @override
  Future<PostModel> getPost(String permalink) {
    return remoteRepository.getPost(permalink);
  }
}
