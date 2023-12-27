import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final StoragePrefsManager storagePrefs = StoragePrefsManager();

class StoragePrefsManager {
  late SharedPreferences sharedPrefInstance;
  late FlutterSecureStorage storageInstance;

  Future<void> init() async {
    sharedPrefInstance = await SharedPreferences.getInstance();
    storageInstance = const FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  //Secure Storage
  static const String USER_DATA_KEY = 'userData';
  static const String ACCESS_TOKEN = 'accessToken';
  static const String NOTIFICATION_TOKEN = 'notificationToken';
  static const String FIRST_RUN = 'firstRun';

  Future<void> setValue(String key, String value) async {
    const IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await storageInstance.write(key: key, value: value);
    print('Set value for $key');
  }

  Future<String> getValue(String key) async {
    final String? result = await storageInstance.read(key: key);
    return result ?? '';
  }

  Future<void> deleteAll() async {
    await storageInstance.deleteAll();
    await storageInstance.delete(key: USER_DATA_KEY);
    await sharedPrefInstance.clear();
  }

  Future<void> deleteForKey(String key) async {
    await storageInstance.delete(key: key);
  }

  Future<void> seEmailToShared(String value) async {
    sharedPrefInstance.setString('email', value);
  }

  Future<String?> readEmailFromShared() async {
    return sharedPrefInstance.getString('email');
  }
}
