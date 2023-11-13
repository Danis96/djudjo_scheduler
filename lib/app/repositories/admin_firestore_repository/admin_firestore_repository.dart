import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class AdminFirestoreRepository {

  AdminFirestoreRepository(){
    firestore = FirebaseFirestore.instance;
    adminsCollection = firestore!.collection('admins');
  }

  FirebaseFirestore? firestore;
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