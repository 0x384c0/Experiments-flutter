import '../../features_reddit_posts_domain.dart';

class PostsInteractorImpl implements PostsInteractor {
  PostsInteractorImpl(this.remoteRepository);

  final PostsRemoteRepository remoteRepository;

  @override
  Future<Iterable<PostModel>> getPosts() {
    return remoteRepository.getPosts();
  }

  @override
  Future<PostModel> getPost(String? permalink) {
    return permalink != null
        ? remoteRepository.getPost(permalink)
        : Future.error(const FormatException("permalink is null"));
  }
}
