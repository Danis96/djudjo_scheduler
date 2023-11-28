import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/stupidity_model.dart';

import '../../models/user_model.dart';

class StupidityFirestoreRepository {
  StupidityFirestoreRepository() {
    _firestore = FirebaseFirestore.instance;
    stupidityCollection = _firestore!.collection('stupidity');
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? stupidityCollection;

  Future<String?> addStupidityToFirestore(List<StupidityModel> model) async {
    try {
      for (final StupidityModel s in model) {
        await stupidityCollection!.add(s.toFirestore());
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
