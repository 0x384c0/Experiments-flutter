import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseSecureDao {
  final storage = const FlutterSecureStorage();

  Future<String?> getString(String key) async => await storage.read(key: key);

  setString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  deleteString(String key) async {
    await storage.delete(key: key);
  }
}
