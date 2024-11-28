import 'dart:collection';

import 'package:features_webview_presentation/src/widgets/web_view/utils/file_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebViewManager {
  static final FileDownloader _fileDownloader = FileDownloader();

  static const _fileUrlsQueueSize = 20;
  static final _lastInterceptedFileUrls = Queue<Uri>();

  static InAppWebViewSettings get initialSettings => InAppWebViewSettings(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        useOnDownloadStart: true,
        useHybridComposition: true,
        allowsInlineMediaPlayback: true,
      );

  static Future<PermissionResponse?> onPermissionRequest(
    InAppWebViewController controller,
    PermissionRequest permissionRequest,
  ) async =>
      PermissionResponse(
        action: PermissionResponseAction.GRANT,
        resources: permissionRequest.resources,
      );

  static getShouldOverrideUrlLoading(OnNavigateAction Function(Uri uri)? onNavigate, Function reload) =>
      (InAppWebViewController controller, NavigationAction navigationAction) async {
        final uri = navigationAction.request.url!;
        final url = uri.toString();
        if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
          if (await canLaunchUrlString(url)) {
            await launchUrlString(url);
            return NavigationActionPolicy.CANCEL;
          }
        } else {
          final isFile = _isDocFile(uri);
          final canCancel = navigationAction.isForMainFrame && !isFile && onNavigate != null;
          if (canCancel) {
            final onNavigateAction = onNavigate(Uri.parse(url));
            if (onNavigateAction == OnNavigateAction.redirect && onNavigateAction.uri != null) {
              try {
                return NavigationActionPolicy.CANCEL;
              } finally {
                await Future.delayed(const Duration(milliseconds: 300));
                controller.loadUrl(urlRequest: URLRequest(url: WebUri.uri(onNavigateAction.uri!)));
              }
            } else if (onNavigateAction == OnNavigateAction.cancelAndReload) {
              try {
                return NavigationActionPolicy.CANCEL;
              } finally {
                reload();
              }
            } else if (onNavigateAction == OnNavigateAction.cancel) {
              return NavigationActionPolicy.CANCEL;
            }
          }
          return NavigationActionPolicy.ALLOW;
        }
      };

  static onDownloadStartRequest(InAppWebViewController controller, DownloadStartRequest request) async {
    final uri = request.url;
    _lastInterceptedFileUrls.add(uri);
    if (_lastInterceptedFileUrls.length >= _fileUrlsQueueSize) _lastInterceptedFileUrls.removeFirst();
    final cookies = await getCookies(uri);
    final downloadedFile = await _fileDownloader.downloadFile(
      url: uri,
      headers: {"Cookie": cookies},
      mimeType: request.mimeType,
    );
    OpenFile.open(downloadedFile?.path);
  }

  static preventCookiesFromExpire(Uri url) async {
    final cookieManager = CookieManager.instance();
    final expiresDate = DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch;

    (await cookieManager.getCookies(url: WebUri.uri(url)))
        .where((cookie) => cookie.expiresDate == null)
        .forEach((cookie) => cookieManager.setCookie(
              url: WebUri.uri(url),
              name: cookie.name,
              value: cookie.value,
              path: cookie.path ?? '/',
              domain: cookie.domain,
              expiresDate: expiresDate,
              isSecure: cookie.isSecure,
              isHttpOnly: cookie.isHttpOnly,
              sameSite: cookie.sameSite,
            ));
  }

  static deleteAllCookies() => CookieManager.instance().deleteAllCookies();

  static getCookie(Uri url, String name) => CookieManager.instance().getCookie(url: WebUri.uri(url), name: name);

  static getCookies(Uri url) async => (await CookieManager.instance().getCookies(url: WebUri.uri(url)))
      .map((cookie) => '${cookie.name}=${cookie.value}')
      .join('; ');

  static bool _isDocFile(Uri uri) {
    if (_lastInterceptedFileUrls.contains(uri)) return true;
    final fileString = [
      ".doc",
      ".docx",
      ".pdf",
      ".txt",
      ".rtf",
      ".odt",
      ".xls",
      ".xlsx",
      ".csv",
      ".ppt",
      ".pptx",
      "pdf",
    ];
    final isFile = fileString.any(uri.toString().contains);
    return isFile;
  }

  static bool shouldIgnoreError(
    Uri? url,
    WebResourceError error,
  ) =>
      url != null ? _isDocFile(url) : false;
}

class OnNavigateAction {
  final String action;
  final Uri? uri;

  const OnNavigateAction._(this.action, this.uri);

  // Enum-like options
  static const OnNavigateAction allow = OnNavigateAction._('allow', null);
  static const OnNavigateAction cancel = OnNavigateAction._('cancel', null);
  static const OnNavigateAction cancelAndReload = OnNavigateAction._('cancelAndReload', null);
  static const OnNavigateAction redirect = OnNavigateAction._('redirect', null);

  // Factory for redirect case
  factory OnNavigateAction.redirectWithUrl(Uri uri) => OnNavigateAction._('redirect', uri);

  @override
  String toString() => action;

  @override
  bool operator ==(other) => other is OnNavigateAction ? other.action == action : false;

  @override
  int get hashCode => action.hashCode;
}
