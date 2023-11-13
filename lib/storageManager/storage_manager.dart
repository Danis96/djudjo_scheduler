import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  StorageManager();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const String USER_DATA_KEY = 'userData';
  static const String BLUETOOTH_KEY = 'bluetoothKey';
  static const String NOTIFICATION_TOKEN = 'notificationToken';

  Future<void> setValue(String key, String value) async {
    const IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await storage.write(key: key, value: value, iOptions: options);
  }

  Future<String> getValue(String key) async {
    final String? result = await storage.read(key: key);
    return result ?? '';
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
