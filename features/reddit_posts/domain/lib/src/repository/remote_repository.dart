import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

abstract class PostsRemoteRepository {
  Future<PostsModel> getPosts({required String? after});

  Future<PostModel> getPost({
    required String permalink,
    String? commentsAfter,
  });
}
