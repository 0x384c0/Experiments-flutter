import 'dart:io';

void main() async {
  // Get the current version from the Git commit count
  final gitProcess = await Process.run('git', ['rev-list', '--all', '--count']);
  if (gitProcess.exitCode != 0) {
    print('Failed to get Git version count: ${gitProcess.stderr}');
    exit(1);
  }

  final version = gitProcess.stdout.trim();
  final filePath = 'apps/app_main/pubspec.yaml';

  final pubspecFile = File(filePath);
  if (!pubspecFile.existsSync()) {
    print('pubspec.yaml not found at $filePath');
    exit(1);
  }

  // Read the contents of the pubspec.yaml file
  final pubspecContent = await pubspecFile.readAsString();

  // Use a regular expression to replace the patch version
  final updatedContent = pubspecContent.replaceFirstMapped(
    RegExp(r'(version:\s*\d+\.\d+\.\d+\+)\d+'),
        (match) => '${match.group(1)}$version',
  );

  // Write the updated content back to the file
  await pubspecFile.writeAsString(updatedContent);

  print('Patch version in pubspec.yaml has been updated to $version.');
}