import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';

import '../data/post_details_state.dart';
import '../data/post_state.dart';

class PostModelMapper extends Mapper<PostModel, PostDetailsState> {
  @override
  PostDetailsStatePopulated map(PostModel input) {
    return PostDetailsStatePopulated(
        input.permalink,
        PostItemState(
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
        ));
  }
}
