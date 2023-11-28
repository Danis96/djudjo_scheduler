import 'package:cloud_firestore/cloud_firestore.dart';

class StupidityModel {
  StupidityModel({this.textValue = ''});

  factory StupidityModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? data = snapshot.data();
    return StupidityModel(textValue: data!['text_value'] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'textValue': textValue};

  final String? textValue;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      if (textValue != null) 'textValue': textValue,
    };
  }
}
