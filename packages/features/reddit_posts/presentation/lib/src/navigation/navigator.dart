import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

@Deprecated('use https://pub.dev/packages/auto_route#using-pageview')
/// Navigation for weather feature
abstract class PostsNavigator {
  Widget home();
}

/// Private implementation if weather navigation
class NavigatorImpl implements PostsNavigator {
  @override
  home() => const PostsHomeScreen();
}
