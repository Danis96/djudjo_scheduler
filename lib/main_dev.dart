import 'package:djudjo_scheduler/app/utils/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/MyApp.dart';
import 'app/locator.dart';
import 'app/providers/storage_manager/storage_prefs_manager.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storagePrefs.init();
  await firebaseInitialize();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues(appName: 'DjudjoInk'));
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
    ),
  ).then((FirebaseApp value) => print('Firebase Initialize'));
}

// A new function callback when a crash occurs.
void onCrash(Object exception, StackTrace stackTrace) {
  // Prints the exception and the stack trace locally
  print(exception);
  print(stackTrace);
  // Send the strack trace to Crashlytics
  FirebaseCrashlytics.instance.recordError(exception, stackTrace);
}
