import 'dart:io';

import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'web_view_manager.dart';

/// WebView without any navigation components, like app bar
class WebViewEmbeddedScreen extends StatefulWidget {
  /// [Uri] that will be loaded after WebView creation
  final Uri uri;

  /// if true, a [LoadingIndicator] will be shown before first page loaded
  final bool? showLoading;

  /// headers that will be injected to initialUrlRequest
  final Map<String, String>? headers;

  /// Allow intercept navigation event, if returns true then navigation event will not be allowed
  final OnNavigateAction Function(Uri uri)? onNavigate;

  /// Used to get cookies after page load
  final Function(WebUri uri, String cookies)? onStopLoading;

  WebViewEmbeddedScreen({
    required this.uri,
    this.showLoading,
    this.onNavigate,
    this.onStopLoading,
    this.headers,
  }) : super(key: ValueKey(uri));

  @override
  State<WebViewEmbeddedScreen> createState() => _WebViewEmbeddedScreenState();
}

class _WebViewEmbeddedScreenState extends State<WebViewEmbeddedScreen>
    with AutomaticKeepAliveClientMixin<WebViewEmbeddedScreen> {
  final GlobalKey _webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  var _initialLoading = true;
  var _isLoading = false;
  var _loadingProgress = 0;
  String? _errorMessage;
  late PullToRefreshController _pullToRefreshController;

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(onRefresh: _refresh);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: [
      InAppWebView(
        key: _webViewKey,
        initialUrlRequest: URLRequest(url: WebUri.uri(widget.uri), headers: widget.headers),
        initialSettings: WebViewManager.initialSettings,
        pullToRefreshController: _pullToRefreshController,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          if (mounted) {
            debugPrint("WebViewEmbeddedPage.onLoadStart $url");
          }
        },
        onPermissionRequest: WebViewManager.onPermissionRequest,
        shouldOverrideUrlLoading: WebViewManager.getShouldOverrideUrlLoading(widget.onNavigate, _refresh),
        onLoadStop: (controller, url) async {
          _pullToRefreshController.endRefreshing();
          setState(() {
            _initialLoading = false;
          });
          if (url case var url?) await WebViewManager.preventCookiesFromExpire(url);
          if (widget.onStopLoading != null && url != null) {
            widget.onStopLoading!(url, await WebViewManager.getCookies(url));
          }
        },
        onReceivedError: (controller, request, error) {
          _pullToRefreshController.endRefreshing();
          if (WebViewManager.shouldIgnoreError(request.url, error)) return;
          setState(() {
            _initialLoading = false;
            _errorMessage = error.description;
          });
        },
        onDownloadStartRequest: _onDownloadStartRequest,
        onProgressChanged: (_, progress) => setState(() => _loadingProgress = progress),
      ),
      if ((widget.showLoading ?? false) && (_initialLoading || _isLoading))
        LoadingIndicator(value: _loadingProgress == 0 ? null : _loadingProgress.toDouble() / 100.0),
      if (_errorMessage?.isNotEmpty == true)
        ErrorView(
          errorDescription: _errorMessage,
          transparent: false,
          refresh: () async => await _refresh(),
        ),
    ]);
  }

  _onDownloadStartRequest(InAppWebViewController controller, DownloadStartRequest request) async {
    try {
      if (widget.showLoading == true) {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
      }
      await WebViewManager.onDownloadStartRequest(controller, request);
    } finally {
      if (widget.showLoading == true) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _refresh() async {
    try {
      if (widget.onNavigate != null) {
        _webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri.uri(widget.uri), headers: widget.headers));
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
