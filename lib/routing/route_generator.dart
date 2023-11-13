import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/view/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/providers/splash_provider/splash_provider.dart';
import '../app/utils/navigation_animations.dart';
import '../app/view/login_page/login_page.dart';
import '../app/view/splash_page/splash_page.dart';
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
            widget: Provider<SplashProvider>(create: (_) => SplashProvider(defaultRoute: Login), lazy: false, child: SplashPage()));
      case Login:
        return SlideAnimationTween(widget: ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider(), child: LoginPage()));
      case Register:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<LoginProvider>.value(value: settings.arguments as LoginProvider, child: RegisterPage()));

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
