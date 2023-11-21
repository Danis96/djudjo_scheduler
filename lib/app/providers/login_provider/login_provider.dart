import 'dart:convert';

import 'package:djudjo_scheduler/app/models/user_model.dart';
import 'package:djudjo_scheduler/app/repositories/admin_firestore_repository/admin_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../storage_manager/storage_prefs_manager.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider() {
    _adminFirestoreRepository = AdminFirestoreRepository();
    firebase = FirebaseAuth.instance;
  }

  FirebaseAuth? firebase;

  AdminFirestoreRepository? _adminFirestoreRepository;

  //login
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  //register
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerConfirmPasswordController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();

  Admin _admin = Admin();

  Admin get admin => _admin;

  Future<String?> registerUser() async {
    if (areFieldsCompletedRegister()) {
      try {
        final UserCredential user = await firebase!
            .createUserWithEmailAndPassword(email: registerEmailController.text, password: registerConfirmPasswordController.text);
        await _setLoggedUserToAdminModel(user.user!);
        await _adminFirestoreRepository!.addAdminToFirestore(_admin);
        await _setUserDataToStorage(_admin);
      } on FirebaseAuthException catch (e) {
        return e.message;
      } catch (e) {
        return e.toString();
      }
      return null;
    } else {
      return Language.all_fields;
    }
  }

  Future<String?> loginUser() async {
    try {
      if (areFieldsCompletedLogin()) {
        final UserCredential user = await firebase!.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );
        await _setLoggedUserToAdminModel(user.user!);
        await _setUserDataToStorage(_admin);
      } else {
        return Language.all_fields;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _setLoggedUserToAdminModel(User user) async {
    _admin = Admin(
      email: user.email,
      creationTime: user.metadata.creationTime.toString(),
      id: user.uid,
      lastSignIn: user.metadata.lastSignInTime.toString(),
      name: registerNameController.text,
      phone: registerPhoneController.text,
    );
  }

  Future<String?> logout() async {
    try {
      await firebase!.signOut();
      await storagePrefs.deleteAll();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _setUserDataToStorage(Admin admin) async {
    await storagePrefs.deleteForKey(StoragePrefsManager.USER_DATA_KEY);
    await storagePrefs.setValue(StoragePrefsManager.USER_DATA_KEY, json.encode(admin.toFirestore()));
  }

  bool areFieldsCompletedLogin() => loginPasswordController.text.isNotEmpty && loginEmailController.text.isNotEmpty;

  bool areFieldsCompletedRegister() =>
      registerPasswordController.text.isNotEmpty &&
      registerConfirmPasswordController.text.isNotEmpty &&
      registerPhoneController.text.isNotEmpty &&
      registerNameController.text.isNotEmpty &&
      registerEmailController.text.isNotEmpty;

  bool areRegPasswordIdentical() =>
      registerConfirmPasswordController.text.isNotEmpty &&
      registerPasswordController.text.isNotEmpty &&
      (registerConfirmPasswordController.text == registerPasswordController.text);
}
