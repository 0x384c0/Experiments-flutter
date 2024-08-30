import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for weather feature
abstract class PostsNavigator {
  Widget homePage();

  toPostDetails(PostItemState state);

  toPostsRemoteFirst();

  toPostsLocalFirst();

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements PostsNavigator {
  @override
  homePage() => const HomePage();

  /// https://github.com/flutter/flutter/issues/147857
  /// Flutter Web engine removes query parameter encoding, so this url cannot be opened manually in browser
  @override
  toPostDetails(PostItemState state) => Modular.to.pushNamed(
        '${RoutesModule.path}${RoutesModule.postDetails}?${Params.permalink}=${state.permalink}',
        arguments: state,
      );

  @override
  toPostsLocalFirst() => Modular.to.pushNamed('${RoutesModule.path}${RoutesModule.postsLocalFirst}');

  @override
  toPostsRemoteFirst()  => Modular.to.pushNamed('${RoutesModule.path}${RoutesModule.postsRemoteFirst}');

  @override
  back() => Modular.to.pop();
}
