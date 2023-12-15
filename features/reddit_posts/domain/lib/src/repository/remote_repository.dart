
import '../../features_reddit_posts_domain.dart';

abstract class PostsRemoteRepository {
  Future<Iterable<PostModel>> getPosts();
  Future<PostModel> getPost(String permalink);
}