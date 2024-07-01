import 'dart:io';

import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:features_webview_presentation/src/widgets/web_view/web_view_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


/// Fullscreen WebView page with navigation components, like app bar
class WebViewPage extends StatefulWidget {
  /// [WebUri] that will be loaded after WebView creation
  final WebUri uri;

  /// headers that will be injected to initialUrlRequest
  final Map<String, String>? headers;

  /// Allow intercept navigation event, if returns true then navigation event will not be allowed
  /// if not null, action buttons on app bar will be hidden
  final OnNavigateAction Function(Uri uri)? onNavigate;

  /// Used to get cookies after page load
  final Function(Uri uri, String cookies)? onStopLoading;

  const WebViewPage({
    super.key,
    required this.uri,
    this.headers,
    this.onNavigate,
    this.onStopLoading,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GlobalKey _webViewKey = GlobalKey();
  bool _canGoBack = false;
  bool _canGoForward = false;
  bool _initialLoading = true;
  String? _errorMessage;

  InAppWebViewController? _webViewController;

  late PullToRefreshController _pullToRefreshController;
  String _url = "";

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: widget.onNavigate == null
              ? [
                  _NavigationControls(
                    webViewController: () => _webViewController,
                    canGoBack: _canGoBack,
                    canGoForward: _canGoForward,
                  )
                ]
              : null,
        ),
        body: SafeArea(
            child: Stack(children: [
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
                debugPrint("WebViewPage.onLoadStart $url");
                setState(() {
                  this._url = url.toString();
                });
              }
            },
            androidOnPermissionRequest: WebViewManager.androidOnPermissionRequest,
            shouldOverrideUrlLoading: WebViewManager.getShouldOverrideUrlLoading(widget.onNavigate, _refresh),
            onLoadStop: (controller, url) async {
              final bool canGoBack = await _webViewController?.canGoBack() ?? false;
              final bool canGoForward = await _webViewController?.canGoForward() ?? false;
              _pullToRefreshController.endRefreshing();
              setState(() {
                _initialLoading = false;
                _canGoBack = canGoBack;
                _canGoForward = canGoForward;
                _url = url.toString();
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
                _url = url.toString();
              });
            },
            onDownloadStartRequest: WebViewManager.onDownloadStartRequest,
          ),
          if (_initialLoading) const LoadingIndicator(),
          if (_errorMessage?.isNotEmpty == true)
            ErrorView(
              errorDescription: _errorMessage,
              transparent: false,
              refresh: () async => await _refresh(),
            ),
        ])));
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
}

class _NavigationControls extends StatelessWidget {
  const _NavigationControls({
    required this.webViewController,
    required this.canGoBack,
    required this.canGoForward,
  });

  final InAppWebViewController? Function() webViewController;
  final bool canGoBack;
  final bool canGoForward;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: canGoBack ? () async => await _goBack() : null,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: canGoForward ? () async => await _goForward() : null,
        ),
        IconButton(icon: const Icon(Icons.replay), onPressed: () => webViewController()?.reload()),
      ],
    );
  }

  _goBack() async => await webViewController()?.canGoBack() == true ? await webViewController()?.goBack() : null;

  _goForward() async =>
      await webViewController()?.canGoForward() == true ? await webViewController()?.goForward() : null;
}
