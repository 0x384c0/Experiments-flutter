import '../../features_reddit_posts_domain.dart';

/// requests data from API
abstract class PostsInteractor {
  /// return list of [PostsModel] from API
  Future<Iterable<PostModel>> getPosts();

  /// return single [PostsModel] with comments from API
  Future<PostModel> getPost(String? permalink);
}
