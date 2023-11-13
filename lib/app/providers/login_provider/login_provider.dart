import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djudjo_scheduler/app/models/user_model.dart';
import 'package:djudjo_scheduler/app/providers/base_provider.dart';
import 'package:djudjo_scheduler/app/providers/provider_utils/provider_constants.dart';
import 'package:djudjo_scheduler/app/repositories/admin_firestore_repository/admin_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends BaseProvider {
  LoginProvider() {
    _adminFirestoreRepository = AdminFirestoreRepository();
  }

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


  Admin? _admin = Admin();
  Admin? get admin => _admin;

  Future<String?> registerUser() async {
    if (areFieldsCompleted()) {
      try {
        await firebase!.createUserWithEmailAndPassword(email: loginEmailController.text, password: loginPasswordController.text).then(
          (UserCredential user) async {
            await _setLoggedUserToAdminModel(user.user!);
            await _adminFirestoreRepository!.addAdminToFirestore(_admin!);
          },
        );
      } on FirebaseAuthException catch (e) {
        returnErrorMsgFirebaseAuthReg(e.code);
      } catch (e) {
        return e.toString();
      }
      return null;
    } else {
      return Language.all_fields;
    }
  }

  Future<String?> loginUser() async {
    if (areFieldsCompleted()) {
      try {
        await firebase!.signInWithEmailAndPassword(email: loginEmailController.text, password: loginPasswordController.text).then(
          (UserCredential user) async {
            await _setLoggedUserToAdminModel(user.user!);
          },
        );
      } on FirebaseAuthException catch (e) {
        returnErrorMsgFirebaseAuthLogin(e.code);
      } catch (e) {
        return e.toString();
      }
      return null;
    } else {
      return Language.all_fields;
    }
  }

  Future<void> _setLoggedUserToAdminModel(User user) async {
    _admin = Admin(
      email: user.email,
      creationTime: user.metadata.creationTime.toString(),
      id: user.uid,
      lastSignIn: user.metadata.lastSignInTime.toString(),
      name: user.displayName,
      phone: user.phoneNumber,
    );
  }

  String? returnErrorMsgFirebaseAuthReg(String e) {
    if (e == ProviderConstants.f_weak_password_code) {
      return Language.weak_password;
    } else if (e == ProviderConstants.f_email_already_in_use) {
      return Language.acc_exist;
    } else {
      return null;
    }
  }

  String? returnErrorMsgFirebaseAuthLogin(String e) {
    if (e == ProviderConstants.f_user_not_found) {
      return Language.user_not_found;
    } else if (e == ProviderConstants.f_wrong_password) {
      return Language.wrong_password;
    } else {
      return null;
    }
  }

  bool areFieldsCompleted() => loginPasswordController.text.isNotEmpty && loginEmailController.text.isNotEmpty;
}
