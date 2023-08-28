import 'package:features_reddit_posts_presentation/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/widgets/post_details_cubit.dart';
import 'package:features_reddit_posts_presentation/widgets/post_details_page.dart';
import 'package:features_reddit_posts_presentation/widgets/posts_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoutesModule extends Module {
  static const path = '/posts';
  static const postDetails = '/post_details';

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const PostsPage()),
        ChildRoute(postDetails, child: (context, args) {
          var permalink = args.queryParams[Params.permalink];
          var postItemState = args.data is PostItemState ? args.data : null;
          var state = postItemState != null
              ? PostDetailsStateEmptyComments(permalink, postItemState)
              : PostDetailsStateEmpty(permalink);
          return BlocProvider.value(
            value: PostDetailsCubit(state),
            child: PostDetailsPage(),
          );
        }),
      ];
}

class Params {
  static const permalink = 'permalink';
}
