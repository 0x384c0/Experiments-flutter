import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebViewsPage extends StatelessWidget {
  const WebViewsPage({super.key});

  WebViewNavigator get _navigator => Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(locale.webview_embedded),
          onTap: _navigator.toEmbeddedWebView,
        ),
        ListTile(
          title: Text(locale.webview_fullscreen),
          onTap: _navigator.toFullscreenWebView,
        ),
      ],
    ).padding(all: 8);
  }
}
