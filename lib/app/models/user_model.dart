import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  Admin({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.creationTime = '',
    this.lastSignIn = '',
  });

  factory Admin.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? data = snapshot.data();
    return Admin(
      name: data!['name'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      creationTime: data['creationTime'] as String,
      lastSignIn: data['lastSignIn'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'email': email, 'phone': phone, 'creationTime': creationTime, 'lastSignIn': lastSignIn};

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? creationTime;
  final String? lastSignIn;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (creationTime != null) 'creationTime': creationTime,
      if (lastSignIn != null) 'lastSignIn': lastSignIn,
    };
  }
}
