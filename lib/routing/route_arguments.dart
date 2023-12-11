import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';

class ProfilePageArguments {
  ProfilePageArguments(this.appointmentProvider, this.loginProvider);

  final AppointmentProvider appointmentProvider;
  final LoginProvider loginProvider;
}
