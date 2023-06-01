library data;

import 'package:features_reddit_posts_data/api/reddit_api.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  RemoteRepositoryImpl(this.redditApi);

  RedditApi redditApi;

  @override
  Future<List<PostModel>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
}
