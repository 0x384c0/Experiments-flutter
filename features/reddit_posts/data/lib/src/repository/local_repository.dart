import 'package:features_reddit_posts_data/src/db/posts_dao.dart';
import 'package:features_reddit_posts_data/src/db/posts_database.dart';
import 'package:features_reddit_posts_data/src/mapper/posts_entity_to_model_mapper.dart';
import 'package:features_reddit_posts_data/src/mapper/posts_model_to_entity_mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class LocalRepositoryImpl implements PostsLocalRepository {
  LocalRepositoryImpl(this._postsModelToEntityMapper, this._postsEntityToModelMapper);

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
  final _postsDao = PostsDao(PostsDatabase());

  static const _defaultPageId = 0;

  final PostsModelToEntityMapper _postsModelToEntityMapper;
  final PostsEntityToModelMapper _postsEntityToModelMapper;

  @override
  Future insertPosts(
    PostsModel data, {
    required String? after,
  }) async {
    final id = after?.hashCode ?? _defaultPageId;

    final (postsEntity, postEntities) = _postsModelToEntityMapper.map((data, id));

    await _postsDao.insertPostsEntity(postsEntity);
    await _postsDao.insertPostEntities(postEntities);
  }

  @override
  Future<PostsModel?> getPosts({
    required String? after,
  }) async {
    final id = after?.hashCode ?? _defaultPageId;
    final postsEntityData = await _postsDao.getPostsEntityForId(id);
    final postEntityData = await _postsDao.getPostEntityForPostsEntity(postsEntityData!);
    return _postsEntityToModelMapper.map((postsEntityData, postEntityData));
  }

  @override
  Future deletePosts() => _postsDao.deleteAll();
//endregion
}
