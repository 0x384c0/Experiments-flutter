import 'package:features_reddit_posts_domain/data/post_model.dart';

abstract class PostsRemoteRepository {
  Future<Iterable<PostModel>> getPosts();
  Future<PostModel> getPost(String permalink);
}