import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:features_webview_presentation/l10n/app_localizations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:features_webview_presentation/src/navigation/router.gr.dart';

@RoutePage()
class WebViewsScreen extends StatelessWidget {
  const WebViewsScreen({super.key});

  static final _testUri = WebUri.uri(Uri.parse("https://file-examples.com/index.php/sample-documents-download/sample-pdf-download/"));

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(locale.webview_embedded),
          onTap: () => AutoRouter.of(context).push(EmbeddedWebViewRoute(uri: _testUri)),
        ),
        ListTile(
          title: Text(locale.webview_fullscreen),
          onTap: () => AutoRouter.of(context).push(WebViewRoute(uri: _testUri)),
        ),
      ],
    ).padding(all: 8);
  }
}
