import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_details_state.dart';
import '../data/post_state.dart';
import '../widgets/post_details_cubit.dart';
import '../widgets/post_details_page.dart';
import '../widgets/posts_page.dart';

class RoutesModule extends Module {
  static const path = '/posts';
  static const postDetails = '/post_details';

  @override
  void routes(r) {
    r.child('/', child: (context) => const PostsPage());
    r.child(postDetails, child: (context) {
      var permalink = r.args.queryParams[Params.permalink];
      var postItemState = r.args.data is PostItemState ? r.args.data : null;
      var state = postItemState != null
          ? PostDetailsStateEmptyComments(permalink, postItemState)
          : PostDetailsStateEmpty(permalink);
      return BlocProvider(
        create: (_) => PostDetailsCubit(state),
        child: PostDetailsPage(),
      );
    });
  }
}

class Params {
  static const permalink = 'permalink';
}
