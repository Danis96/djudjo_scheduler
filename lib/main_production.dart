import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/MyApp.dart';
import 'app/locator.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((FirebaseApp value) => print('Firebase Initialize'));
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlavorConfig(flavor: Flavor.PRODUCTION, values: FlavorValues(appName: 'DjudjoInk Dev'));
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterDownloader.initialize(debug: true);
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    setupLocator();
    runApp(MyApp());
  });
}

// A new function callback when a crash occurs.
void onCrash(Object exception, StackTrace stackTrace) {
  // Prints the exception and the stack trace locally
  print(exception);
  print(stackTrace);
  // Send the strack trace to Crashlytics
  FirebaseCrashlytics.instance.recordError(exception, stackTrace);
}
