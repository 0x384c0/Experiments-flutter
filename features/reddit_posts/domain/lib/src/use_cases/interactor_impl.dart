import 'package:features_reddit_posts_domain/src/data/more_model.dart';
import 'package:features_reddit_posts_domain/src/data/post_model.dart';
import 'package:features_reddit_posts_domain/src/repository/remote_repository.dart';
import 'package:features_reddit_posts_domain/src/use_cases/interactor.dart';

class PostsInteractorImpl implements PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

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
  }) =>
      moreModel != null && moreModel.children.isNotEmpty
          ? remoteRepository.getMoreChildren(
              linkId: moreModel.parentId,
              children: moreModel.children,
            )
          : Future.value([]);
}
