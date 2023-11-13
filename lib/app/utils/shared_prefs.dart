import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<bool> readCodeFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('registration_is_code') ?? false;
  }

  Future<String> readEmailFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('registration_email') ?? '';
  }

  Future<void> writeSharedVersion(bool registrationIsCode, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('registration_is_code', registrationIsCode);
    prefs.setString(
      'registration_email',
      email,
    );
  }

  Future<void> setFirstRun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_run', false);
  }

  Future<bool> isFirstRun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result = prefs.containsKey('first_run');
    print(result);
    return !result;
  }

  Future<void> setIsOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnboarding', true);
  }

  Future<bool> isOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result = prefs.containsKey('isOnboarding');
    print(result);
    return result;
  }

  Future<void> setIsAndroidPermissionsCalled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAndroidPermissionsCalled', true);
  }

  Future<bool> isAndroidPermissionsCalled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result = prefs.containsKey('isAndroidPermissionsCalled');
    return result;
  }

  Future<void> setLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', language);
  }

  Future<String> defaultLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_code') ?? 'en';
  }

  Future<void> setHomeOnboardingFinished() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('home_onboarding_finised', true);
  }

  Future<bool> isHomeOnboardingFinished() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('home_onboarding_finised') ?? false;
  }

  Future<void> setPermissionKeyShowedOnce(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool?> readPermissionKeyShowedOnce(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? ss = prefs.getBool(key);
    return ss;
  }

  Future<void> setPermissionsShowedOnce() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('permissions_finished', true);
  }

  Future<bool> permissionShowedOnce() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('permissions_finished') ?? false;
  }
}
