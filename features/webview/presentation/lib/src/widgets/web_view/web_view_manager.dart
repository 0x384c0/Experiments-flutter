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
            if (onNavigateAction == OnNavigateAction.cancelAndReload) {
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

  static preventCookiesFromExpire(WebUri url) async {
    final cookieManager = CookieManager.instance();
    final expiresDate = DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch;

    (await cookieManager.getCookies(url: url))
        .where((cookie) => cookie.expiresDate == null)
        .forEach((cookie) => cookieManager.setCookie(
              url: url,
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

  static getCookie(WebUri url, String name) => CookieManager.instance().getCookie(url: url, name: name);

  static getCookies(WebUri url) async => (await CookieManager.instance().getCookies(url: url))
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

enum OnNavigateAction {
  allow,
  cancel,
  cancelAndReload,
}
