import 'package:features_reddit_posts_presentation/widgets/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for weather feature
abstract class RedditPostsNavigator {
  Widget homePage();

  back();
}

/// Private implementation if weather navigation
class RedditPostsNavigatorImpl implements RedditPostsNavigator {
  @override
  homePage() {
    return const PostsPage();
  }

  @override
  back() {
    Modular.to.pop();
  }
}
