import 'dart:io';

import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'web_view_manager.dart';

/// WebView without any navigation components, like app bar
class WebViewEmbeddedPage extends StatefulWidget {
  /// [WebUri] that will be loaded after WebView creation
  final WebUri uri;

  /// if true, a [LoadingIndicator] will be shown before first page loaded
  final bool? showLoading;

  /// headers that will be injected to initialUrlRequest
  final Map<String, String>? headers;

  /// Allow intercept navigation event, if returns true then navigation event will not be allowed
  final OnNavigateAction Function(Uri uri)? onNavigate;

  /// Used to get cookies after page load
  final Function(WebUri uri, String cookies)? onStopLoading;

  WebViewEmbeddedPage({
    required this.uri,
    this.showLoading,
    this.onNavigate,
    this.onStopLoading,
    this.headers,
  }) : super(key: ValueKey(uri));

  @override
  State<WebViewEmbeddedPage> createState() => _WebViewEmbeddedPageState();
}

class _WebViewEmbeddedPageState extends State<WebViewEmbeddedPage>
    with AutomaticKeepAliveClientMixin<WebViewEmbeddedPage> {
  final GlobalKey _webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  String _url = "";
  bool _initialLoading = true;
  String? _errorMessage;
  late PullToRefreshController _pullToRefreshController;

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: _refresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: [
      InAppWebView(
        key: _webViewKey,
        initialUrlRequest: URLRequest(url: widget.uri, headers: widget.headers),
        initialOptions: WebViewManager.options,
        pullToRefreshController: _pullToRefreshController,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          if (mounted) {
            debugPrint("WebViewEmbeddedPage.onLoadStart $url");
            setState(() {
              this._url = url.toString();
            });
          }
        },
        androidOnPermissionRequest: WebViewManager.androidOnPermissionRequest,
        shouldOverrideUrlLoading: WebViewManager.getShouldOverrideUrlLoading(widget.onNavigate, _refresh),
        onLoadStop: (controller, url) async {
          _pullToRefreshController.endRefreshing();
          setState(() {
            _initialLoading = false;
            this._url = url.toString();
          });
          if (url case var url?) await WebViewManager.preventCookiesFromExpire(url);
          if (widget.onStopLoading != null && url != null) {
            widget.onStopLoading!(url, await WebViewManager.getCookies(url));
          }
        },
        onLoadError: (controller, url, code, message) {
          _pullToRefreshController.endRefreshing();
          if (WebViewManager.shouldIgnoreError(url, code, message)) return;
          setState(() {
            _initialLoading = false;
            _errorMessage = message;
          });
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          setState(() {
            this._url = url.toString();
          });
        },
        onDownloadStartRequest: WebViewManager.onDownloadStartRequest,
      ),
      if ((widget.showLoading ?? false) && _initialLoading) const LoadingIndicator(),
      if (_errorMessage?.isNotEmpty == true)
        ErrorView(
          errorDescription: _errorMessage,
          transparent: false,
          refresh: () async => await _refresh(),
        ),
    ]);
  }

  _refresh() async {
    try {
      if (widget.onNavigate != null) {
        _webViewController?.loadUrl(urlRequest: URLRequest(url: widget.uri, headers: widget.headers));
      } else if (Platform.isAndroid) {
        _webViewController?.reload();
      } else if (Platform.isIOS) {
        _webViewController?.loadUrl(
            urlRequest: URLRequest(url: await _webViewController?.getUrl(), headers: widget.headers));
      }
      setState(() {
        if (_errorMessage?.isNotEmpty == true) _initialLoading = true;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
