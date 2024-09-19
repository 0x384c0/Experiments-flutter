import 'package:features_webview_presentation/src/widgets/web_view/web_view_embedded_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EmbeddedWebViewPage extends StatelessWidget {
  const EmbeddedWebViewPage({super.key, required this.uri});

  final WebUri uri;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: WebViewEmbeddedScreen(
          uri: uri,
          showLoading: true,
        ),
      );
}
