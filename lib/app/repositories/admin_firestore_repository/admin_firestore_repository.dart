import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class AdminFirestoreRepository {

  AdminFirestoreRepository(){
    _firestore = FirebaseFirestore.instance;
    _adminsCollection = _firestore!.collection('admins');
  }

  FirebaseFirestore? _firestore;
  CollectionReference<dynamic>? _adminsCollection;

  Future<String?> addAdminToFirestore(Admin user) async {
    try {
      await _adminsCollection!.add(user.toFirestore());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Admin>?> fetchAdminsFromFirestore() async {
    final List<Admin> _model = <Admin>[];
    try {
      await _adminsCollection!.get().then((QuerySnapshot<dynamic> value) {
         for(final QueryDocumentSnapshot<dynamic> doc in value.docs) {
           final Admin admin = Admin.fromFirestore(doc);
           _model.add(admin);
         }
      });
      return _model;
    } catch (e) {
      return null;
    }
  }

  Future<String?> updateAdminToFirestore(Admin admin) async {
    try {
      await _adminsCollection!.doc(admin.id).update(admin.toFirestore());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}