import 'package:djudjo_scheduler/app/repositories/navigation_repo.dart';
import 'package:flutter/material.dart';

import '../routing/route_generator.dart';
import '../routing/routes.dart';
import '../theme/custom_light_theme.dart';
import '../theme/theme_config.dart';
import 'locator.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: buildApp(),
    );
  }

  Widget buildApp() {
    return MaterialApp(
      navigatorKey: locator<NavigationRepo>().navigationKey,
      title: 'DjudjoInk',
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(data: data.copyWith(textScaleFactor: 1.0), child: child!);
      },
      initialRoute: Splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}
