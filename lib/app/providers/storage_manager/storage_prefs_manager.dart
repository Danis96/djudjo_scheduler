import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final StoragePrefsManager storagePrefs = StoragePrefsManager();

class StoragePrefsManager {
  late SharedPreferences _shared_pref_instance;
  late FlutterSecureStorage _storage_instance;

  Future<void> init() async {
    _shared_pref_instance = await SharedPreferences.getInstance();
    _storage_instance = const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
    );
  }

  //Secure Storage
  static const String USER_DATA_KEY = 'userData';
  static const String ACCESS_TOKEN = 'accessToken';
  static const String NOTIFICATION_TOKEN = 'notificationToken';
  static const String FIRST_RUN = 'firstRun';



  Future<void> setValue(String key, String value) async {
    const IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await _storage_instance.write(key: key, value: value,);
    print('Set value for $key');
  }

  Future<String> getValue(String key) async {
    final String? result = await _storage_instance.read(key: key);
    return result ?? '';
  }

  Future<void> deleteAll() async {
    await _storage_instance.deleteAll();
    await _storage_instance.delete(key: USER_DATA_KEY);
    await _shared_pref_instance.clear();
  }

  Future<void> deleteForKey(String key) async {
    await _storage_instance.delete(key: key);
  }


  Future<void> seEmailToShared(String value) async {
    _shared_pref_instance.setString('email', value);
  }

  Future<String?> readEmailFromShared() async {
    return _shared_pref_instance.getString('email');
  }
  
}
