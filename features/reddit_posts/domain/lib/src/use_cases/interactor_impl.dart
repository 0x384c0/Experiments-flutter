import '../../features_reddit_posts_domain.dart';

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
}
