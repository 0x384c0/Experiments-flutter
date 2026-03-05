import 'package:features_reddit_posts_presentation/src/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Navigation for weather feature
@Deprecated('use https://pub.dev/packages/auto_route#using-pageview')
abstract class PostsNavigator {
  Widget home();
}

/// Private implementation if weather navigation
@Injectable(as: PostsNavigator)
class NavigatorImpl implements PostsNavigator {
  @override
  home() => const PostsHomeScreen();
}
