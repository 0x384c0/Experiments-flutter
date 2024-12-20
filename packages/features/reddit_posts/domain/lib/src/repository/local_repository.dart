import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

abstract class PostsLocalRepository {
  // PostsModel
  Future<PostsModel?> getPosts({
    required String? after,
  });

  Future insertPosts(
    PostsModel data, {
    required String? after,
  });

  Future deletePosts();

  // PostModel
  Future<PostModel?> getPost({
    required String permalink,
  });

  Future insertPost(
    PostModel data, {
    required String permalink,
  });

  // More PostModel
  Future<Iterable<PostModel>?> getMoreChildren({
    required String linkId,
    required Iterable<String> children,
  });

  Future insertMoreChildren(
    Iterable<PostModel> data, {
    required String linkId,
    required Iterable<String> children,
  });
}
