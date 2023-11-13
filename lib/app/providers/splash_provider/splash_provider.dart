import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../repositories/navigation_repo.dart';
import '../storage_manager/storage_prefs_manager.dart';

class SplashProvider {
  SplashProvider(
    String baseUrl, {
    this.defaultRoute = '/login',
  }) {
    onInit(baseUrl);
  }

  final NavigationRepo _navigationService = locator<NavigationRepo>();
  final String defaultRoute;

  Future<void> onInit(String baseUrl) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storagePrefs.deleteAll();
      prefs.setBool('first_run', false);
    }
    final String userData = await storagePrefs.getValue(StoragePrefsManager.USER_DATA_KEY);
    final bool logged = isUserLoggedIn(userData);
    if (logged) {

    } else {
      _navigationService.navigateAndRemove(defaultRoute);
    }
  }

  bool isUserLoggedIn(String userData) {
    return userData != '';
  }
}
