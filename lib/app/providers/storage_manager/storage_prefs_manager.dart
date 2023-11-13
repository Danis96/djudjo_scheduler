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
  }

  Future<void> deleteForKey(String key) async {
    await _storage_instance.delete(key: key);
  }


  Future<void> setConsents(String value) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    _shared_pref_instance.setString('consents', value);
    // await _storage_instance.write(key: 'consents', value: value);
  }

  Future<String?> readConsents() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    return _shared_pref_instance.getString('consents');
    // final String? _c = await _storage_instance.read(key: 'consents');
    // return _c;
  }
  
}
