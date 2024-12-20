import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';

class FileDownloader extends ChangeNotifier {
  Future<File?> downloadFile({
    required Uri url,
    Map<String, dynamic>? headers,
    String? mimeType,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = url.path.split('/').last + DateTime.now().toString();
      final filePath = '${tempDir.path}/$fileName.${extensionFromMime(mimeType ?? 'text/plain')}';

      final httpClient = HttpClient();
      final request = await httpClient.getUrl(url);
      // Add headers if provided
      headers?.forEach((key, value) {
        request.headers.add(key, value);
      });

      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        final file = File(filePath);
        await file.writeAsBytes(bytes);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
