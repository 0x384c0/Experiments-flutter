import '../../features_reddit_posts_domain.dart';

class PostsInteractorImpl implements PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

  final PostsRemoteRepository remoteRepository;

  @override
  Future<PostsModel> getPosts({required String? after}) => remoteRepository.getPosts(after: after);

  @override
  Future<PostModel> getPost({
    required String? permalink,
    String? commentsAfter,
  }) =>
      permalink != null
          ? remoteRepository.getPost(permalink: permalink, commentsAfter: commentsAfter)
          : Future.error(const FormatException("permalink is null"));
}
