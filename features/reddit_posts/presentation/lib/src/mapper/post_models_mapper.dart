import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/post_state.dart';

class PostModelsMapper extends Mapper<Iterable<PostModel>, Iterable<PostItemState>> {
  @override
  map(Iterable<PostModel> input) => input
      .where((element) => element.permalink != null)
      .map((e) => PostItemState(e.permalink!, e.author ?? "", e.category ?? "", e.icon, e.title ?? "", null));
}
