import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/navigation/routes_module.dart';
import 'package:features_reddit_posts_presentation/widgets/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for weather feature
abstract class Navigator {
  Widget homePage();

  toPostDetails(PostItemState state);

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements Navigator {
  @override
  homePage() {
    return const PostsPage();
  }

  @override
  toPostDetails(PostItemState state) {
    Modular.to.pushNamed('${RoutesModule.path}${RoutesModule.postDetails}?${Params.permalink}=${state.permalink}',
        arguments: state);
  }

  @override
  back() {
    Modular.to.pop();
  }
}
