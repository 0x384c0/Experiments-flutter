import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';

class PostModelsMapper extends Mapper<List<PostModel>, PostsState> {
  @override
  PostsState map(List<PostModel> input) {
    return PostsStatePopulated(input
        .where((element) => element.permalink != null)
        .map((e) => PostItemState(
              e.permalink!,
              e.author ?? "",
              e.category ?? "",
              e.icon ?? "",
              e.title ?? "",
              null,
            ))
        .toList());
  }
}
