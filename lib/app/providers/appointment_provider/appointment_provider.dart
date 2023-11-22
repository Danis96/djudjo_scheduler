import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/repositories/appointment_firestore_repository/appointment_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider() {
    _appointmentFirestoreRepository = AppointmentFirestoreRepository();
  }

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

  // details model
  Appointment _appointmentDetails = Appointment();

  Appointment get appointmentDetails => _appointmentDetails;

  void setAppointmentDetails(Appointment value) {
    _appointmentDetails = value;
  }

  Future<String?> addAppointment() async {
    if (!areMandatoryFieldsEmpty()) {
      setDataToAppointmentModel();
      final String? result = await _appointmentFirestoreRepository!.addAppointmentToFirestore(_appointment);
      return result;
    } else {
      return Language.mandatory_fields;
    }
  }

  Future<String?> fetchAppointments() async {
    final dynamic result = await _appointmentFirestoreRepository!.fetchAppointments();
    if (result is List<Appointment>) {
      _appointments = result;
      sortAppointmentsByDate();
    } else {
      print(result.toString());
    }
    notifyListeners();
  }

  void sortAppointmentsByDate() {
    _appointments.sort(
      (Appointment a, Appointment b) =>
          DateFormat('dd.MM.yyyy').parse(a.suggestedDate).compareTo(DateFormat('dd.MM.yyyy').parse(b.suggestedDate)),
    );
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
    if (isSelectedDateInPast()) {
      appointmentFinished = true;
    }
    notifyListeners();
  }

  bool isSelectedDateInPast() {
    final DateTime currentDate = DateTime.now();
    String selectedFirst = '';
    if (dateController.text.isNotEmpty) {
      if (dateController.text.contains('-')) {
        selectedFirst = dateController.text.split(' - ')[0];
      } else {
        selectedFirst = dateController.text;
      }
      final DateTime selectedDate = DateFormat('dd.MM.yyyy').parse(selectedFirst);
      if (selectedDate.isBefore(currentDate)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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

  final List<String> assetsForSlider = <String>[
    'assets/ic_slide_1.png',
    'assets/ic_slide_2.png',
    'assets/ic_slide_3.png',
    'assets/ic_slide_4.png',
  ];

  List<Widget> valuesWidget = <Widget>[];

  void setValuesForSlider() {
    for (int i = 0; i < assetsForSlider.length; i++) {
      valuesWidget.add(Container(child: Image.asset(assetsForSlider[i])));
    }
  }

  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(mask: '###-###/###', type: MaskAutoCompletionType.lazy);
}
