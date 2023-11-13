import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  BaseProvider() {
    firebase = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  FirebaseAuth? firebase;
  FirebaseFirestore? firestore;
}
