import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WebViewsPage extends StatelessWidget {
  const WebViewsPage({super.key});

  WebViewNavigator get _navigator => Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _navigator.toEmbeddedWebView,
          child: Text(locale.webview_embedded),
        ),
        ElevatedButton(
          onPressed: _navigator.toFullscreenWebView,
          child: Text(locale.webview_fullscreen),
        ),
      ],
    ).padding(all: 8);
  }
}
