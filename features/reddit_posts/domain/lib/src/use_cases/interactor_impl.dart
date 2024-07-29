import 'dart:math';

import 'package:features_reddit_posts_domain/src/data/more_model.dart';
import 'package:features_reddit_posts_domain/src/data/post_model.dart';
import 'package:features_reddit_posts_domain/src/repository/remote_repository.dart';
import 'package:features_reddit_posts_domain/src/use_cases/interactor.dart';

class PostsInteractorImpl implements PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

  final _perPage = 20;

  final PostsRemoteRepository remoteRepository;

  @override
  Future<PostsModel> getPosts({required String? after}) => remoteRepository.getPosts(after: after);

  @override
  Future<PostModel> getPost({
    required String? permalink,
  }) =>
      permalink != null
          ? remoteRepository.getPost(permalink: permalink)
          : Future.error(const FormatException("permalink is null"));

  @override
  Future<Iterable<PostModel>> getMoreChildren({
    required int page,
    required MoreModel? moreModel,
  }) async {
    if (moreModel == null || moreModel.children.isEmpty) return [];
    if (page > moreModel.children.length) return [];
    return remoteRepository.getMoreChildren(
      linkId: moreModel.parentId,
      children: moreModel.children.sublist((page - 1) * _perPage, min(page * _perPage, moreModel.children.length)),
    );
  }
}
