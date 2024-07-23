import 'package:features_reddit_posts_domain/src/data/more_model.dart';
import 'package:features_reddit_posts_domain/src/data/post_model.dart';

/// requests data from API
abstract class PostsInteractor {
  /// return list of [PostsModel] from API
  Future<PostsModel> getPosts({required String? after});

  /// return single [PostsModel] with comments from API
  Future<PostModel> getPost({
    required String? permalink,
  });

  Future<Iterable<PostModel>> getMoreChildren({
    required int page,
    required MoreModel? moreModel,
  });
}
