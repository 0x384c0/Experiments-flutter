import 'package:features_webview_presentation/src/widgets/web_views_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Deprecated('use auto_route directly')
/// Navigation for feature
abstract class WebViewNavigator {
  Widget home();
}

/// Private implementation of navigation
@Injectable(as: WebViewNavigator)
class NavigatorImpl implements WebViewNavigator {
  @override
  home() => const WebViewsScreen();
}
