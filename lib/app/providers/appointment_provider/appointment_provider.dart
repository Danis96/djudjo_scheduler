import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/repositories/appointment_firestore_repository/appointment_firestore_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider() {
    _firestore = FirebaseFirestore.instance;
    _appointmentsCollection = _firestore!.collection('appointments');
    _appointmentFirestoreRepository = AppointmentFirestoreRepository();
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? _appointmentsCollection;
  AppointmentFirestoreRepository? _appointmentFirestoreRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placementController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imgController = TextEditingController();

  bool appointmentFinished = false;
  TimeOfDay firstTime = const TimeOfDay(hour: 9, minute: 30);
  TimeOfDay lastTime = const TimeOfDay(hour: 23, minute: 30);

  DateRangePickerController dateRangePickerController = DateRangePickerController();

  List<Appointment> _appointments = <Appointment>[];

  List<Appointment> get appointments => _appointments;

  Appointment _appointment = Appointment();

  Appointment get appointment => _appointment;

  Future<String?> addAppointment() async {
    if (!areMandatoryFieldsEmpty()) {
      setDataToAppointmentModel();
      final String? result = await _appointmentFirestoreRepository!.addAppointmentToFirestore(_appointmentsCollection!, _appointment);
      return result;
    }
    return 'Need to fulfill all mandatory fields.';
  }

  void setDataToAppointmentModel() {
    _appointment = Appointment(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      // this is true [appointmentConfirmed] because when admin creates appointment it is automatically confirmed
      appointmentConfirmed: true,
      id: emailController.text + '_id',
      appointmentFinished: appointmentFinished,
      description: descriptionController.text,
      size: sizeController.text,
      placement: placementController.text,
      suggestedDate: dateController.text,
      suggestedTime: timeController.text,
      dateRange: dateController.text + ' ' + timeController.text,
      // todo add img upload
    );
  }

  void setImageToController(String value) {
    imgController.text = value;
  }

  void setAppointmentFinished(bool value) {
    appointmentFinished = value;
    print('appointmentConfirmed $value');
    notifyListeners();
  }

  void setFormattedDateRange(DateRangePickerSelectionChangedArgs args) {
    if (args.value.endDate != null) {
      if (args.value.startDate as DateTime == args.value.endDate as DateTime) {
        dateController.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
      } else {
        dateController.text = '${DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime)} -'
            ' ${DateFormat('dd.MM.yyyy').format(args.value.endDate as DateTime)}';
      }
    } else {
      dateController.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
    }

    notifyListeners();
  }

  bool areMandatoryFieldsEmpty() =>
      nameController.text.isEmpty &&
      emailController.text.isEmpty &&
      phoneController.text.isEmpty &&
      timeController.text.isEmpty &&
      dateController.text.isEmpty;

  void clearControllers() {
    nameController.clear();
    dateController.clear();
    timeController.clear();
    emailController.clear();
    phoneController.clear();
    descriptionController.clear();
    sizeController.clear();
    placementController.clear();
    appointmentFinished = false;
  }
}
