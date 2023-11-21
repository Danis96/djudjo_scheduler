import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/appointment_model.dart';

class AppointmentFirestoreRepository {

  Future<String?> addAppointmentToFirestore(CollectionReference<dynamic> reference, Appointment appointment) async {
    try {
      await reference.doc().set(appointment.toFirestore());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchAppointments(CollectionReference<dynamic> reference,) async {
    try {
      final QuerySnapshot<dynamic> value = await reference.get();
      return value;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
