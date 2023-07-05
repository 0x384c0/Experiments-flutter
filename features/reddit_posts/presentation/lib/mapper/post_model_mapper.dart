import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';

class PostModelMapper extends Mapper<PostModel, PostItemState> {
  @override
  PostItemState map(PostModel input) {
    return PostItemState(
      input.permalink ?? "",
      input.author ?? "",
      input.category ?? "",
      input.icon ?? "",
      input.title ?? "",
      input.comments
          ?.map((e) => PostItemState(
                e.permalink ?? "",
                e.author ?? "",
                e.category ?? "",
                e.icon ?? "",
                e.title ?? "",
                null,
              ))
          .where((element) => element.title.isNotEmpty),
    );
  }
}
