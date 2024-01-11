import 'package:djudjo_scheduler/app/utils/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/MyApp.dart';
import 'app/locator.dart';
import 'app/utils/storage_manager/storage_prefs_manager.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storagePrefs.init();
  await firebaseInitialize();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues(appName: AppName.APP_NAME));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    setupLocator();
    runApp(MyApp());
  }, onError: onCrash);
}

Future<void> firebaseInitialize() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: FirebaseConstants.API_KEY,
      appId: FirebaseConstants.APP_ID,
      messagingSenderId: FirebaseConstants.MESSAGING_SENDER_ID,
      projectId: FirebaseConstants.PROJECT_ID,
      storageBucket: FirebaseConstants.STORAGE_BUCKET,
    ),
  ).then((FirebaseApp value) => print('Firebase Initialize ${DateTime.now().toString().split(' ')[0]}'));
}

void onCrash(Object exception, StackTrace stackTrace) {
  print(exception);
  print(stackTrace);
  FirebaseCrashlytics.instance.recordError(exception, stackTrace);
}
