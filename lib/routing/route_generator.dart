import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/providers/stupidity_provider/stupidity_provider.dart';
import 'package:djudjo_scheduler/app/view/bottom_navigation_bar/bottom_navigation_page.dart';
import 'package:djudjo_scheduler/app/view/change_password_page/change_password_page.dart';
import 'package:djudjo_scheduler/app/view/edit_page/edit_page.dart';
import 'package:djudjo_scheduler/app/view/favorites_page/favorites_page.dart';
import 'package:djudjo_scheduler/app/view/forgot_password_page/forgot_password_page.dart';
import 'package:djudjo_scheduler/app/view/history_page/history_page.dart';
import 'package:djudjo_scheduler/app/view/notification_page/notification_page.dart';
import 'package:djudjo_scheduler/app/view/profile_page/profile_page.dart';
import 'package:djudjo_scheduler/app/view/register_page/register_page.dart';
import 'package:djudjo_scheduler/app/view/settings_page/settings_page.dart';
import 'package:djudjo_scheduler/routing/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../app/providers/splash_provider/splash_provider.dart';
import '../app/utils/navigation_animations.dart';
import '../app/view/add_new_appointment_page/add_new_appointment.dart';
import '../app/view/appointment_details_page/appointment_details.dart';
import '../app/view/login_page/login_page.dart';
import '../app/view/splash_page/splash_page.dart';
import '../routing/routes.dart';

mixin RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash:
        return SlideAnimationTween(
            widget: Provider<SplashProvider>(create: (_) => SplashProvider(defaultRoute: Login), lazy: false, child: SplashPage()));
      case Login:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<LoginProvider>(
                create: (_) => LoginProvider(), child: LoginPage(isFromRegister: settings.arguments as bool)));
      case Register:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<LoginProvider>.value(value: settings.arguments as LoginProvider, child: const RegisterPage()));
      case Home:
        return SlideAnimationTween(
            widget: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<AppointmentProvider>(create: (_) => AppointmentProvider()),
            ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
            ChangeNotifierProvider<StupidityProvider>(create: (_) => StupidityProvider()),
          ],
          child: const BottomNavigationPage(initial: 1),
        ));
      case NewAppointment:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AppointmentProvider>.value(
                value: settings.arguments as AppointmentProvider, child: NewAppointmentPage()));
      case AppointmentDetails:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AppointmentProvider>.value(
                value: settings.arguments as AppointmentProvider, child: AppointmentDetailsPage()));
      case Notifications:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AppointmentProvider>.value(
                value: settings.arguments as AppointmentProvider, child: const NotificationPage()));
      case EditAppointment:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AppointmentProvider>.value(value: settings.arguments as AppointmentProvider, child: EditPage()));
      case Profile:
        final ProfilePageArguments args = settings.arguments as ProfilePageArguments;
        return SlideAnimationTween(
            widget: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<AppointmentProvider>.value(value: args.appointmentProvider),
            ChangeNotifierProvider<LoginProvider>.value(value: args.loginProvider),
          ],
          child: const ProfilePage(),
        ));
      case Settings:
        final SettingsPageArguments args = settings.arguments as SettingsPageArguments;
        return SlideAnimationTween(
            widget: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<AppointmentProvider>.value(value: args.appointmentProvider),
            ChangeNotifierProvider<LoginProvider>.value(value: args.loginProvider),
          ],
          child: const SettingsPage(),
        ));
      case ChangePassword:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<LoginProvider>.value(value: settings.arguments as LoginProvider, child: const ChangePasswordPage()));
      case ForgotPassword:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<LoginProvider>.value(value: settings.arguments as LoginProvider, child: const ForgotPasswordPage()));
      case History:
        return SlideAnimationTween(
            widget:
                ChangeNotifierProvider<AppointmentProvider>.value(value: settings.arguments as AppointmentProvider, child: const HistoryPage()));
      case Favorites:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AppointmentProvider>.value(
                value: settings.arguments as AppointmentProvider, child: const FavoritesPage()));
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
