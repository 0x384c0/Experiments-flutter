extension UrlParsing on String {
  Uri? parseUri() {
    Uri? uri;
    try {
      uri = Uri.parse(this);
    } catch (e) {
      return null;
    }
    if (!uri.isAbsolute) {
      return null;
    }
    return uri;
  }
}
