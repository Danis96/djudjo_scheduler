import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/provider_utils/provider_constants.dart';
import 'package:djudjo_scheduler/app/repositories/appointment_firestore_repository/appointment_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/extensions/string_extensions.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider() {
    _appointmentFirestoreRepository = AppointmentFirestoreRepository();
  }

  AppointmentFirestoreRepository? _appointmentFirestoreRepository;

  // add new appointment controllers and variables
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placementController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imgController = TextEditingController();

  bool appointmentFinished = false;
  bool isFavorite = false;
  bool isConfirmed = false;
  bool allDay = false;
  TimeOfDay firstTime = const TimeOfDay(hour: 9, minute: 30);
  TimeOfDay lastTime = const TimeOfDay(hour: 23, minute: 30);
  List<String> genders = <String>[ProviderConstants.MALE, ProviderConstants.FEMALE, ProviderConstants.OTHER];
  String genderValue = 'M';

  // edit appointment controllers and variables
  final TextEditingController eNameController = TextEditingController();
  final TextEditingController ePhoneController = TextEditingController();
  final TextEditingController eEmailController = TextEditingController();
  final TextEditingController eTimeController = TextEditingController();
  final TextEditingController eDateController = TextEditingController();
  final TextEditingController ePlacementController = TextEditingController();
  final TextEditingController eAllergiesController = TextEditingController();
  final TextEditingController eSizeController = TextEditingController();
  final TextEditingController eDescriptionController = TextEditingController();
  final TextEditingController eImgController = TextEditingController();

  DateRangePickerController dateRangePickerController = DateRangePickerController();

  // all appointments
  List<Appointment> _appointments = <Appointment>[];

  List<Appointment> get appointments => _appointments;

  // not confirmed appointments
  final List<Appointment> _appointmentsNotConfirmed = <Appointment>[];

  List<Appointment> get appointmentsNotConfirmed => _appointmentsNotConfirmed;

  // confirmed appointments
  final List<Appointment> _appointmentsConfirmed = <Appointment>[];

  List<Appointment> get appointmentsConfirmed => _appointmentsConfirmed;

  // finished appointments
  final List<Appointment> _appointmentsFinished = <Appointment>[];

  List<Appointment> get appointmentsFinished => _appointmentsFinished;

  // favorite appointments
  final List<Appointment> _appointmentsFavorites = <Appointment>[];

  List<Appointment> get appointmentsFavorites => _appointmentsFavorites;

  Appointment _appointment = Appointment();

  Appointment get appointment => _appointment;

  // details model
  Appointment _appointmentDetails = Appointment();

  Appointment get appointmentDetails => _appointmentDetails;

  void setAppointmentDetails(Appointment value) {
    _appointmentDetails = value;
    notifyListeners();
  }

  void setDataForEdit() {
    eNameController.text = appointmentDetails.name ?? '';
    eDateController.text = appointmentDetails.suggestedDate ?? '';
    eDescriptionController.text = appointmentDetails.description ?? '';
    eEmailController.text = appointmentDetails.email ?? '';
    ePhoneController.text = appointmentDetails.phone ?? '';
    ePlacementController.text = appointmentDetails.placement ?? '';
    eAllergiesController.text = appointmentDetails.allergies ?? '';
    eSizeController.text = appointmentDetails.size ?? '';
    eTimeController.text = appointmentDetails.suggestedTime ?? '';
    isFavorite = appointmentDetails.isFavorite ?? false;
    appointmentFinished = appointmentDetails.appointmentFinished ?? false;
    genderValue = appointmentDetails.gender ?? '';
    isConfirmed = appointmentDetails.appointmentConfirmed ?? false;
    allDay = appointmentDetails.allDay ?? false;
    firstTime = TimeOfDay(
        hour: appointmentDetails.suggestedTime!.returnTimeRangeHours(0),
        minute: appointmentDetails.suggestedTime!.returnTimeRangeMinutes(0));
    notifyListeners();
  }

  void setIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void setAllDay(bool value) {
    allDay = value;
    notifyListeners();
  }

  void setIsConfirmed() {
    isConfirmed = !isConfirmed;
    notifyListeners();
  }

  void setChosenGender(String value) {
    genderValue = value;
    notifyListeners();
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

  Future<String?> updateAppointment() async {
    if (!areMandatoryFieldsEmptyEdit()) {
      setDataToAppointmentModel(isEdit: true);
      final String? result = await _appointmentFirestoreRepository!.updateAppointmentToFirestore(_appointment);
      await fetchAppointments();
      return result;
    } else {
      return Language.mandatory_fields;
    }
  }

  Future<String?> fetchAppointments() async {
    final dynamic result = await _appointmentFirestoreRepository!.fetchAppointments();
    _appointments.clear();
    if (result is List<Appointment>) {
      _appointments = result;
      sortAppointmentsByDate();
      sortNotConfirmedAppointments();
    } else {
      print(result.toString());
    }
    notifyListeners();
    return null;
  }

  Future<String?> deleteAppointment(String id) async {
    try {
      await _appointmentFirestoreRepository!.deleteAppointmentFromFirestore(id);
      await fetchAppointments();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void sortAppointmentsByDate() {
    _appointments.sort(
      (Appointment a, Appointment b) =>
          DateFormat('dd.MM.yyyy').parse(a.suggestedDate!).compareTo(DateFormat('dd.MM.yyyy').parse(b.suggestedDate!)),
    );
  }

  void sortNotConfirmedAppointments() {
    _appointmentsNotConfirmed.clear();
    _appointmentsConfirmed.clear();
    _appointmentsFinished.clear();
    _appointmentsFavorites.clear();
    if (_appointments.isNotEmpty) {
      for (final Appointment a in _appointments) {
        if (!a.appointmentConfirmed!) {
          _appointmentsNotConfirmed.add(a);
        } else if (a.appointmentFinished!) {
          if (a.isFavorite!) {
            _appointmentsFavorites.add(a);
          }
          _appointmentsFinished.add(a);
        } else {
          if (a.isFavorite!) {
            _appointmentsFavorites.add(a);
          }
          _appointmentsConfirmed.add(a);
        }
      }
    }
  }

  void setDataToAppointmentModel({bool isEdit = false}) {
    _appointment = Appointment(
      name: isEdit ? eNameController.text : nameController.text,
      email: isEdit ? eEmailController.text : emailController.text,
      phone: isEdit ? ePhoneController.text : phoneController.text,
      id: _appointmentDetails.id,
      // this is true [appointmentConfirmed] because when admin creates appointment it is automatically confirmed [isEdit = false]
      isFavorite: isFavorite,
      allDay: allDay,
      // ignore: avoid_bool_literals_in_conditional_expressions
      appointmentConfirmed: isEdit ? isConfirmed : true,
      gender: genderValue,
      appointmentFinished: appointmentFinished,
      description: isEdit ? eDescriptionController.text : descriptionController.text,
      size: isEdit ? eSizeController.text : sizeController.text,
      placement: isEdit ? ePlacementController.text : placementController.text,
      allergies: isEdit ? eAllergiesController.text : allergiesController.text,
      suggestedDate: isEdit ? eDateController.text : dateController.text,
      suggestedTime: isEdit
          ? allDay
              ? ProviderConstants.ALL_DAY_TIME
              : eTimeController.text
          : allDay
              ? ProviderConstants.ALL_DAY_TIME
              : timeController.text,
      dateRange: isEdit ? eDateController.text + ' ' + eTimeController.text : dateController.text + ' ' + timeController.text,
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

  void setFormattedDateRangeEdit(DateRangePickerSelectionChangedArgs args) {
    if (args.value.endDate != null) {
      if (args.value.startDate as DateTime == args.value.endDate as DateTime) {
        eDateController.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
      } else {
        eDateController.text = '${DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime)} -'
            ' ${DateFormat('dd.MM.yyyy').format(args.value.endDate as DateTime)}';
      }
    } else {
      eDateController.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
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

  bool isSelectedDateInPastEdit() {
    final DateTime currentDate = DateTime.now();
    String selectedFirst = '';
    if (eDateController.text.isNotEmpty) {
      if (eDateController.text.contains('-')) {
        selectedFirst = eDateController.text.split(' - ')[0];
      } else {
        selectedFirst = eDateController.text;
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

  bool areMandatoryFieldsEmptyEdit() =>
      eNameController.text.isEmpty &&
      eEmailController.text.isEmpty &&
      ePhoneController.text.isEmpty &&
      eTimeController.text.isEmpty &&
      eDateController.text.isEmpty;

  void clearControllers() {
    nameController.clear();
    dateController.clear();
    timeController.clear();
    emailController.clear();
    phoneController.clear();
    descriptionController.clear();
    sizeController.clear();
    placementController.clear();
    allergiesController.clear();
    appointmentFinished = false;
    allDay = false;
    firstTime = const TimeOfDay(hour: 9, minute: 30);
    lastTime = const TimeOfDay(hour: 23, minute: 30);
  }

  void clearControllersEdit() {
    eNameController.clear();
    eDateController.clear();
    eTimeController.clear();
    eEmailController.clear();
    ePhoneController.clear();
    eDescriptionController.clear();
    eSizeController.clear();
    ePlacementController.clear();
    eAllergiesController.clear();
    appointmentFinished = false;
    allDay = false;
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

  String returnGenderImage(String gender) {
    switch (gender) {
      case 'M':
      case 'Male':
        return 'assets/man.png';
      case 'F':
      case 'Female':
        return 'assets/woman.png';
      default:
        return 'assets/other.png';
    }
  }

  String returnGenderValue() {
    switch (genderValue) {
      case 'M':
      case 'Male':
        return 'Male';
      case 'F':
      case 'Female':
        return 'Female';
      default:
        return 'Other';
    }
  }

  bool showUnConfirmedList = false;

  void setShowUnConfirmedList() {
    showUnConfirmedList = !showUnConfirmedList;
    notifyListeners();
  }
}
