import 'package:features_reddit_posts_presentation/src/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/widgets/home_page.dart';
import 'package:features_reddit_posts_presentation/src/widgets/local_first_posts_widget.dart';
import 'package:features_reddit_posts_presentation/src/widgets/post_details_page.dart';
import 'package:features_reddit_posts_presentation/src/widgets/posts_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

//TODO: rename to PostsRoutesModule
class RoutesModule extends Module {
  static const path = '/posts';
  static const postDetails = '/post_details';
  static const postsRemoteFirst = '/posts_remote_first';
  static const postsLocalFirst = '/posts_local_first';

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child(postsRemoteFirst, child: (context) => const PostsPage());
    r.child(postsLocalFirst, child: (context) => const LocalFirstPostsWidget());
    r.child(postDetails, child: (context) {
      final permalink = r.args.queryParams[Params.permalink];
      final postItemState = r.args.data is PostItemState ? r.args.data : null;
      final state = PostDetailsState(permalink, postItemState);
      return PostDetailsPage(state: state);
    });
  }
}

class Params {
  static const permalink = 'permalink';
}
