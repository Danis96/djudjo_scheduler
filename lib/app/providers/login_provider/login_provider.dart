import 'package:djudjo_scheduler/app/providers/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginProvider extends BaseProvider {

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<String?> registerUser() async {
    if (areFieldsCompleted()) {
      try {
        await firebase!.createUserWithEmailAndPassword(email: loginEmailController.text, password: loginPasswordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        }
      } catch (e) {
        return e.toString();
      }
      return null;
    } else {
      return 'Sva polja moraju biti popunjena';
    }
  }






  bool areFieldsCompleted() => loginPasswordController.text.isNotEmpty && loginEmailController.text.isNotEmpty;

}