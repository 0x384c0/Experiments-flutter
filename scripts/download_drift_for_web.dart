import 'dart:io';

void main(List<String> args) async {
  final baseDir = Directory('apps/app_main').absolute.path;

  final lockFilePath = '$baseDir/pubspec.lock';
  final destDir = '$baseDir/web/drift';

  // Function to extract the version of a given library from the pubspec.lock file
  Future<String?> extractVersion(String libraryName) async {
    final lockFile = File(lockFilePath);
    if (!await lockFile.exists()) {
      print('pubspec.lock not found at $lockFilePath');
      return null;
    }

    final lines = await lockFile.readAsLines();
    bool foundLibrary = false;

    for (final line in lines) {
      if (line.trim().startsWith('$libraryName:')) {
        foundLibrary = true;
      } else if (foundLibrary && line.trim().startsWith('version:')) {
        return line.split(':').last.trim().replaceAll('"', '');
      }
    }

    return null;
  }

  // Extract versions for drift and sqlite3
  final driftVersion = await extractVersion('drift');
  final sqlite3Version = await extractVersion('sqlite3');

  if (driftVersion == null || sqlite3Version == null) {
    print('Could not find drift or sqlite3 versions in pubspec.lock.');
    exit(1);
  }

  print('Found versions: Drift - $driftVersion, SQLite3 - $sqlite3Version');

  // Create destination directory if it doesn't exist
  final destDirObj = Directory(destDir);
  if (!await destDirObj.exists()) {
    await destDirObj.create(recursive: true);
  }

  // Define URLs for downloading files
  final driftWorkerUrl =
      'https://github.com/simolus3/drift/releases/download/drift-$driftVersion/drift_worker.js';
  final sqlite3WasmUrl =
      'https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-$sqlite3Version/sqlite3.wasm';

  // Function to download files
  Future<void> downloadFile(String url, String destination) async {
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == 200) {
      final file = File(destination);
      await response.pipe(file.openWrite());
      print('Downloaded $url to $destination');
    } else {
      print('Failed to download $url. HTTP Status: ${response.statusCode}');
    }
  }

  // Download drift_worker.js and sqlite3.wasm
  await downloadFile(driftWorkerUrl, '$destDir/drift_worker.js');
  await downloadFile(sqlite3WasmUrl, '$destDir/sqlite3.wasm');

  print('Downloaded drift_worker.js and sqlite3.wasm to $destDir');
  exit(0);
}