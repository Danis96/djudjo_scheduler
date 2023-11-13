import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/MyApp.dart';
import '../app/providers/splash_provider/splash_provider.dart';
import '../app/utils/navigation_animations.dart';
import '../app/view/splash/splash_page.dart';
import '../config/flavor_config.dart';
import '../routing/routes.dart';

mixin RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    /// these args are for arguments,
    /// if we need to pass some argument we will do it through args
    // final dynamic args = settings.arguments;

    switch (settings.name) {
      case Splash:
        return SlideAnimationTween(
          widget: Provider<SplashProvider>(
            create: (_) => SplashProvider(
              FlavorConfig.instance.values.baseUrl,
              defaultRoute: 'ProviderConstants.START_ROUTE',
            ),
            lazy: false,
            child: SplashPage(),
          ),
        );
      // case OldSignIn:
      // return SlideAnimationTween(
      //   widget: MultiProvider(
      // ignore: always_specify_types
      // providers: [
      //   ChangeNotifierProvider<LoginProvider>(
      //     create: (_) => LoginProvider(),
      //   )
      // ],
      // child: OldLogin(),
      // ),
      // );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<void>(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Container(
            child: const Text('Error Screen'),
          ),
        ),
      );
    });
  }
}
