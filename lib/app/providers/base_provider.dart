import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  BaseProvider() {
    firebase = FirebaseAuth.instance;
  }

  FirebaseAuth? firebase;
}
