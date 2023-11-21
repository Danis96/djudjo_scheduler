import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class AdminFirestoreRepository {

  AdminFirestoreRepository(){
    _firestore = FirebaseFirestore.instance;
    adminsCollection = _firestore!.collection('admins');
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? adminsCollection;

  Future<String?> addAdminToFirestore(Admin user) async {
    try {
      await adminsCollection!.add(user.toFirestore());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}