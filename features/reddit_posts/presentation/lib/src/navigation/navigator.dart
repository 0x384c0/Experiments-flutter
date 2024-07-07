import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_presentation.dart';
import '../data/post_state.dart';
import '../widgets/posts_page.dart';

/// Navigation for weather feature
abstract class PostsNavigator {
  Widget homePage();

  toPostDetails(PostItemState state);

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements PostsNavigator {
  @override
  homePage() => const PostsPage();

  /// https://github.com/flutter/flutter/issues/147857
  /// Flutter Web engine removes query parameter encoding, so this url cannot be opened manually in browser
  @override
  toPostDetails(PostItemState state) => Modular.to.pushNamed(
        '${RoutesModule.path}${RoutesModule.postDetails}?${Params.permalink}=${state.permalink}',
        arguments: state,
      );

  @override
  back() => Modular.to.pop();
}
