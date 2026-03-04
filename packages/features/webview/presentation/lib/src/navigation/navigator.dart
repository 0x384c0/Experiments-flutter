import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:features_webview_presentation/src/widgets/web_views_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

@Deprecated('use auto_route directly')
/// Navigation for feature
abstract class WebViewNavigator {
  Widget home();
}

/// Private implementation of navigation
class NavigatorImpl implements WebViewNavigator {
  @override
  home() => const WebViewsScreen();
}
