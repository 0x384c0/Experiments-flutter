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
        ChildRoute(
          postDetails,
          child: (context, args) => BlocProvider.value(
            value:
                PostDetailsCubit({args.queryParams[Params.permalink]: args.data is PostItemState ? args.data : null}),
            child: const PostDetailsPage(),
          ),
        ),
      ];
}

class Params {
  static const permalink = 'permalink';
}
