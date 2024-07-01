import 'package:features_webview_presentation/src/widgets/web_view/web_view_embedded_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EmbeddedWebViewPage extends StatelessWidget {
  const EmbeddedWebViewPage({super.key});

  @override
  Widget build(BuildContext context) => WebViewEmbeddedPage(
        uri: WebUri.uri(Uri.parse("https://www.google.com/")),
        showLoading: true,
      );
}
