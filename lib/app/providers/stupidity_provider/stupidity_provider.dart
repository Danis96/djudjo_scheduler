import 'package:djudjo_scheduler/app/models/stupidity_model.dart';
import 'package:djudjo_scheduler/app/repositories/stupidity_firestore_repository/stupidity_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/helpers/stupidity_helper.dart';
import 'package:flutter/cupertino.dart';

class StupidityProvider extends ChangeNotifier {
  StupidityProvider() {
    _stupidityFirestoreRepository = StupidityFirestoreRepository();
  }

  StupidityFirestoreRepository? _stupidityFirestoreRepository;

  List<StupidityModel> _models = <StupidityModel>[];

  List<StupidityModel> get models => _models;

  Future<String?> addStupidityToFirestore() async {
    try {
      await _stupidityFirestoreRepository!.addStupidityToFirestore(StupidityHelper().stupidList);
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> fetchStupidities() async {
    final dynamic result = await _stupidityFirestoreRepository!.fetchStupidity();
    if (result is List<StupidityModel>) {
      _models = result;
      _models.shuffle();
      notifyListeners();
      return null;
    } else {
      return result.toString();
    }
  }

  bool stupidityOn = true;

  void setStupidity() {
    stupidityOn = !stupidityOn;
    notifyListeners();
  }
}
