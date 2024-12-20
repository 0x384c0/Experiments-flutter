import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/post_details_state.dart';
import '../data/post_state.dart';

class PostModelToPostDetailsStateMapper extends Mapper<PostModel, PostDetailsState> {
  @override
  PostDetailsState map(PostModel input) => PostDetailsState(
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
        ),
      );
}
