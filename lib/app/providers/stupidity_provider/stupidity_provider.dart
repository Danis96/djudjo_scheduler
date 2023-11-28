import 'package:djudjo_scheduler/app/repositories/stupidity_firestore_repository/stupidity_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/stupidity_helper.dart';
import 'package:flutter/cupertino.dart';

class StupidityProvider extends ChangeNotifier {
  StupidityProvider() {
    _stupidityFirestoreRepository = StupidityFirestoreRepository();
  }

  StupidityFirestoreRepository? _stupidityFirestoreRepository;

  Future<String?> addStupidityToFirestore() async {
    try {
      await _stupidityFirestoreRepository!.addStupidityToFirestore(StupidityHelper().stupidList);
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
