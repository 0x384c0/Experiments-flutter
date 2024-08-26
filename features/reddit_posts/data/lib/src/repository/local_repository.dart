import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class LocalRepositoryImpl implements PostsLocalRepository {
  //region MoreChildren
  final _moreChildrenCache = <int, Iterable<PostModel>>{};

  @override
  Future insertMoreChildren(
    Iterable<PostModel> data, {
    required String linkId,
    required Iterable<String> children,
  }) async {
    final id = Object.hashAll([linkId, ...children]);
    _moreChildrenCache[id] = data;
  }

  @override
  Future<Iterable<PostModel>?> getMoreChildren({
    required String linkId,
    required Iterable<String> children,
  }) async {
    final id = Object.hashAll([linkId, ...children]);
    return _moreChildrenCache[id];
  }

  //endregion

  //region Post
  final _postCache = <int, PostModel>{};

  @override
  Future insertPost(
    PostModel data, {
    required String permalink,
  }) async {
    final id = permalink.hashCode;
    _postCache[id] = data;
  }

  @override
  Future<PostModel?> getPost({
    required String permalink,
  }) async {
    final id = permalink.hashCode;
    return _postCache[id];
  }

  //endregion

  //region Posts
  final _postsCache = <int?, PostsModel>{};

  @override
  Future insertPosts(
    PostsModel data, {
    required String? after,
  }) async {
    final id = after?.hashCode;
    _postsCache[id] = data;
  }

  @override
  Future<PostsModel?> getPosts({
    required String? after,
  }) async {
    final id = after?.hashCode;
    return _postsCache[id];
  }
//endregion
}
