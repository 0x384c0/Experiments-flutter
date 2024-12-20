import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebViewPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<WebViewNavigator>(NavigatorImpl.new);
  }
}
