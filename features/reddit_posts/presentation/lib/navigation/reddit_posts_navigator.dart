import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for weather feature
abstract class RedditPostsNavigator {
  home();

  back();
}

/// Private implementation if weather navigation
class RedditPostsNavigatorImpl implements RedditPostsNavigator {

  @override
  home() {
    Modular.to.pushNamed('/');
  }

  @override
  back() {
    Modular.to.pop();
  }
}