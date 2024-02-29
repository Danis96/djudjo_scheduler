import 'dart:io';
import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/provider_utils/provider_constants.dart';
import 'package:djudjo_scheduler/app/repositories/appointment_firestore_repository/appointment_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/extensions/string_extensions.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider() {
    _appointmentFirestoreRepository = AppointmentFirestoreRepository();
    isImagePicked = false;
    storageRoot = FirebaseStorage.instance.ref();
  }

  AppointmentFirestoreRepository? _appointmentFirestoreRepository;
  Reference? storageRoot;
  Reference? storageDirImages;
  Reference? storageImageToUpload;

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
    assetsForSlider.clear();
    if (_appointmentDetails.pictures != null && _appointmentDetails.pictures!.isNotEmpty) {
      for (final dynamic _p in _appointmentDetails.pictures!) {
        final String _img = _p as String;
        assetsForSlider.add(_img);
      }
    }
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
    _imageList = appointmentDetails.pictures!;
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
      pictures: _imageList,
      suggestedTime: isEdit
          ? allDay
              ? ProviderConstants.ALL_DAY_TIME
              : eTimeController.text
          : allDay
              ? ProviderConstants.ALL_DAY_TIME
              : timeController.text,
      dateRange:
          isEdit ? eDateController.text + ' ' + eTimeController.text : dateController.text + ' ' + timeController.text,
    );
  }

  void setAppointmentFinished(bool value) {
    appointmentFinished = value;
    notifyListeners();
  }

  void setFormattedDateRange(DateRangePickerSelectionChangedArgs args, TextEditingController controller) {
    if (args.value.endDate != null) {
      if (args.value.startDate as DateTime == args.value.endDate as DateTime) {
        controller.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
      } else {
        controller.text = '${DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime)} -'
            ' ${DateFormat('dd.MM.yyyy').format(args.value.endDate as DateTime)}';
      }
    } else {
      controller.text = DateFormat('dd.MM.yyyy').format(args.value.startDate as DateTime);
    }
    if (isSelectedDateInPast(controller)) {
      appointmentFinished = true;
    }
    notifyListeners();
  }

  bool isSelectedDateInPast(TextEditingController controller) {
    final DateTime currentDate = DateTime.now();
    String selectedFirst = '';
    if (controller.text.isNotEmpty) {
      if (controller.text.contains('-')) {
        selectedFirst = controller.text.split(' - ')[0];
      } else {
        selectedFirst = controller.text;
      }
      final DateTime selectedDate = DateFormat('dd.MM.yyyy').parse(selectedFirst);
      return selectedDate.isBefore(currentDate);
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
    isImagePicked = false;
    _imageList.clear();
    imagePaths.clear();
    notifyListeners();
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
    _imageList.clear();
    imagePaths.clear();
    appointmentFinished = false;
    allDay = false;
    isImagePicked = false;
  }

  List<String> assetsForSlider = <String>[];

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

  /// Image part - refactor and extend

  bool isImagePicked = false;
  List<String> imagePaths = <String>[];
  List<dynamic> _imageList = <dynamic>[];

  List<dynamic> get imageList => _imageList;
  int currentSliderIndex = 0;

  void setCurrentSliderIndex(int value) {
    currentSliderIndex = 0;
  }

  Future<void> pickImage(ImageSource source) async {
    imagePaths.clear();
    try {
      final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 100);
      if (pickedFiles != null) {
        isImagePicked = true;
        print('Image paths: ${pickedFiles.map((XFile file) => file.path).toList()}');
        imagePaths = pickedFiles.map((XFile file) => file.path).toList();
      }
    } catch (e) {
      isImagePicked = false;
      print('Error picking image: $e');
    }
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    storageDirImages = storageRoot!.child('appointments');
    try {
      if (imagePaths.isNotEmpty) {
        for (final String path in imagePaths) {
          final String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
          storageImageToUpload = storageDirImages!.child(uniqueFileName);
          final File file = File(path);
          await storageImageToUpload!.putFile(file);
          final String _imgUri = await storageImageToUpload!.getDownloadURL();
          _imageList.add(_imgUri);
        }
        return null;
      }
    } catch (e) {
      print('Image upload issue: $e');
      return e.toString();
    }
  }

  Future<String?> deleteImage() async {
    final String _imgUrl = assetsForSlider[currentSliderIndex];
    storageDirImages = storageRoot!.child('appointments');
    try {
      // Delete from Firebase Storage
      final Reference _imgReference = storageDirImages!.storage.refFromURL(_imgUrl);
      print('IMG REF: $_imgReference');
      await _imgReference.delete();

      // TODO refactor and clean code, extend new provider for iamges

      // Delete from Firestore Appointment
      List<String> _appImgs = <String>[];
      for (final dynamic _i in _appointmentDetails.pictures!) {
        _appImgs.add(_i.toString());
      }

      _appImgs.removeWhere((String element) => element == _imgUrl);

      _appointmentDetails.pictures!.clear();
      _appImgs.forEach((String e) => _appointmentDetails.pictures!.add(e));

      await _appointmentFirestoreRepository!
          .deleteImagesFromFirestore(id: _appointmentDetails.id!, appointment: _appointmentDetails);

      // // Remove from the local list
      _imageList.removeWhere((dynamic image) => image.toString() == _imgUrl);
      assetsForSlider.removeWhere((String element) => element == _imgUrl);

      notifyListeners();
      return null;
    } catch (error) {
      print('Error deleting image: $error');
      return error.toString();
    }
  }
}
