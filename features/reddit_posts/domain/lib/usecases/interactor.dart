import 'package:features_reddit_posts_domain/data/post_model.dart';

/// requests data from API
abstract class PostsInteractor {
  /// return list of [PostsModel] from API
  Future<List<PostModel>> getPosts();
}

class PostsInteractorImpl extends PostsInteractor {
  @override
  Future<List<PostModel>> getPosts() {
    return Future.value(List.generate(
        10,
        (index) => PostModel(
              "permalink",
              "author",
              "category",
              "https://external-preview.redd.it/NWszZmJlM3Z6NTNiMW1BwCtpVDf8j5faduXZq-RKccAC52b2mpYTMxsPrNsJ.png?format=pjpg&auto=webp&v=enabled&s=2af5b356292ca89e78826abb6c282eb2502a7e76",
              "title $index",
            )));
  }
}
