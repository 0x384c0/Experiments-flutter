import 'package:features_webview_presentation/src/widgets/embedded_web_view_screen.dart';
import 'package:features_webview_presentation/src/widgets/web_view/web_view_screen.dart';
import 'package:features_webview_presentation/src/widgets/web_views_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebViewRoutesModule extends Module {
  static const path = '/webview';
  static const embedded = '/embedded';
  static const fullscreen = '/fullscreen';

  final _testUri = WebUri.uri(Uri.parse("https://file-examples.com/index.php/sample-documents-download/sample-pdf-download/"));

  @override
  void routes(r) {
    r.child('/', child: (context) => const WebViewsScreen());
    r.child(embedded, child: (context) => EmbeddedWebViewPage(uri: _testUri));
    r.child(fullscreen, child: (context) => WebViewScreen(uri: _testUri));
  }
}
