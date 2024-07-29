import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';

class PostModelToPostItemStateMapper extends Mapper<PostModel, PostItemState> {
  @override
  PostItemState map(PostModel input) => PostItemState(
        input.permalink ?? "",
        input.author ?? "",
        input.category ?? "",
        input.icon,
        input.title ?? "",
        input.comments
            ?.map((e) => PostItemState(
                  e.permalink ?? "",
                  e.author ?? "",
                  e.category ?? "",
                  e.icon,
                  e.title ?? "",
                  null,
                ))
            .where((element) => element.title.isNotEmpty),
      );
}
