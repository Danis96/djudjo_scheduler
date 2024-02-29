import 'package:djudjo_scheduler/app/utils/constants/constants.dart';
import 'package:djudjo_scheduler/env/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/MyApp.dart';
import 'app/locator.dart';
import 'app/utils/storage_manager/storage_prefs_manager.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
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
    options: FirebaseOptions(
      apiKey: Env.firebaseApiKey!,
      appId: Env.firebaseAppId!,
      messagingSenderId: Env.messagingSenderId!,
      projectId: Env.firebaseProjectId!,
      storageBucket: Env.firebaseStorageBucket!,
    ),
  ).then((FirebaseApp value) => print('Firebase Initialize ${DateTime.now().toString().split(' ')[0]}'));
}

// A new function callback when a crash occurs.
void onCrash(Object exception, StackTrace stackTrace) {
  // Prints the exception and the stack trace locally
  print(exception);
  print(stackTrace);
  // Send the strack trace to Crashlytics
  FirebaseCrashlytics.instance.recordError(exception, stackTrace);
}
