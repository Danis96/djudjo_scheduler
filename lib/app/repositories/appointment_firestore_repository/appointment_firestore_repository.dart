import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/appointment_model.dart';

class AppointmentFirestoreRepository {

  AppointmentFirestoreRepository() {
    _firestore = FirebaseFirestore.instance;
    _appointmentsCollection = _firestore!.collection('appointments');
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? _appointmentsCollection;

  Future<String?> addAppointmentToFirestore(Appointment appointment) async {
    try {
      await _appointmentsCollection!.add(appointment.toFirestore());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchAppointments() async {
    List<Appointment> _appointments = <Appointment>[];
    try {
      await _appointmentsCollection!.get().then((QuerySnapshot<dynamic> value) {
         for(final DocumentSnapshot<dynamic> doc in value.docs) {
            final Appointment _app = Appointment.fromFirestore(doc);
            _appointments.add(_app);
         }
      });
      return _appointments;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
