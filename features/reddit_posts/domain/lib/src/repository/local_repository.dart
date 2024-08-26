import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

abstract class PostsLocalRepository {
  Future<PostsModel?> getPosts({
    required String? after,
  });

  Future insertPosts(
    PostsModel data, {
    required String? after,
  });

  Future<PostModel?> getPost({
    required String permalink,
  });

  Future insertPost(
    PostModel data, {
    required String permalink,
  });

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
