import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/stupidity_model.dart';

import '../../models/user_model.dart';

class StupidityFirestoreRepository {
  StupidityFirestoreRepository() {
    _firestore = FirebaseFirestore.instance;
    _stupidityCollection = _firestore!.collection('stupidity');
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? _stupidityCollection;

  Future<String?> addStupidityToFirestore(List<StupidityModel> model) async {
    try {
      for (final StupidityModel s in model) {
        await _stupidityCollection!.add(s.toFirestore());
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchStupidity() async {
    List<StupidityModel> _model = <StupidityModel>[];
    try {
      await _stupidityCollection!.get().then((QuerySnapshot<dynamic> value) {
        for(final DocumentSnapshot<dynamic> doc in value.docs) {
          final StupidityModel _app = StupidityModel.fromFirestore(doc);
          _model.add(_app);
        }
      });
      return _model;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
