import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:features_webview_presentation/src/widgets/web_views_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation for feature
abstract class WebViewNavigator {
  Widget home();

  Future<Object?> toFullscreenWebView();

  Future<Object?> toEmbeddedWebView();

  back();
}

/// Private implementation of navigation
class NavigatorImpl implements WebViewNavigator {
  @override
  home() => const WebViewsScreen();

  @override
  toFullscreenWebView() => Modular.to.pushNamed('${WebViewRoutesModule.path}${WebViewRoutesModule.fullscreen}');

  @override
  toEmbeddedWebView() => Modular.to.pushNamed('${WebViewRoutesModule.path}${WebViewRoutesModule.embedded}');

  @override
  back() => Modular.to.pop();
}
