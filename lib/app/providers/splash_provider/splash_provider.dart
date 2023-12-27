import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../repositories/navigation_repo.dart';
import '../../utils/storage_manager/storage_prefs_manager.dart';

class SplashProvider {
  SplashProvider({this.defaultRoute = '/login'}) {
    onInit();
  }

  final NavigationRepo _navigationService = locator<NavigationRepo>();
  final String defaultRoute;

  Future<void> onInit() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storagePrefs.deleteAll();
      prefs.setBool('first_run', false);
    }
    final String userData = await storagePrefs.getValue(StoragePrefsManager.USER_DATA_KEY);
    final bool logged = isUserLoggedIn(userData);
    if (logged) {
      _navigationService.navigateAndRemove(Home);
    } else {
      _navigationService.navigateAndRemove(defaultRoute, arguments: false);
    }
  }

  bool isUserLoggedIn(String userData) => userData != '';
}
