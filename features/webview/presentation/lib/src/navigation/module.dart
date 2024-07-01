import 'package:features_webview_presentation/src/widgets/embedded_web_view_page.dart';
import 'package:features_webview_presentation/src/widgets/web_view/web_view_page.dart';
import 'package:features_webview_presentation/src/widgets/web_views_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebViewRoutesModule extends Module {
  static const path = '/webview';
  static const embedded = '/embedded';
  static const fullscreen = '/fullscreen';

  @override
  void routes(r) {
    r.child('/', child: (context) => const WebViewsPage());
    r.child(embedded, child: (context) => const EmbeddedWebViewPage());
    r.child(fullscreen, child: (context) => WebViewPage(uri: WebUri.uri(Uri.parse("https://www.google.com/"))));
  }
}
