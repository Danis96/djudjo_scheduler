import 'dart:convert';

import 'package:djudjo_scheduler/app/models/user_model.dart';
import 'package:djudjo_scheduler/app/repositories/admin_firestore_repository/admin_firestore_repository.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  //profile
  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController profilePhoneController = TextEditingController();
  final TextEditingController profileNameController = TextEditingController();

  //change password
  final TextEditingController cpOldController = TextEditingController();
  final TextEditingController cpNewController = TextEditingController();
  final TextEditingController cpConfirmController = TextEditingController();

  Admin _admin = Admin();

  Admin get admin => _admin;

  List<Admin>? _admins = <Admin>[];

  List<Admin> get admins => _admins!;

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
    return null;
  }

  Future<String?> fetchAdmins() async {
    try {
      _admins = await _adminFirestoreRepository!.fetchAdminsFromFirestore();
      getCurrentUser();
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> updateCurrentAdmin() async {
    try {
      setProfileEditChanges();
      await _adminFirestoreRepository!.updateAdminToFirestore(_admin);
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> reAuthenticateAdminAndChangePassword() async {
    try {
      if (areChangePasswordFieldsEmpty()) {
        if (areChangePasswordNewConfirmMatch()) {
          final User? _user = FirebaseAuth.instance.currentUser;
          final AuthCredential _authCredential = EmailAuthProvider.credential(email: _user!.email!, password: cpOldController.text);
          await _user.reauthenticateWithCredential(_authCredential);
          await _user.updatePassword(cpConfirmController.text);
          notifyListeners();
          return null;
        } else {
          return Language.confirm_pass;
        }
      } else {
        return Language.all_fields;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void setProfileEditChanges() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (_admins != null && _admins!.isNotEmpty) {
      for (final Admin _a in _admins!) {
        if (_a.email! == user!.email!) {
          _admin = Admin(
            phone: profilePhoneController.text,
            email: profileEmailController.text,
            name: profileNameController.text,
            lastSignIn: _a.lastSignIn,
            id: _a.id,
            creationTime: _a.creationTime,
          );
        }
      }
    }
  }

  void getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (_admins != null && _admins!.isNotEmpty) {
      for (final Admin _a in _admins!) {
        if (_a.email! == user!.email!) {
          _admin = _a;
        }
      }
    }
    profileEmailController.text = _admin.email ?? '';
    profileNameController.text = _admin.name ?? '';
    profilePhoneController.text = _admin.phone ?? '';
    notifyListeners();
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

  bool changesOccurred = false;

  void setChangesOccurred() {
    if (profileNameController.text != _admin.name ||
        profilePhoneController.text != _admin.phone ||
        profileEmailController.text != _admin.email) {
      changesOccurred = true;
    } else {
      changesOccurred = false;
    }
    notifyListeners();
  }

  String appVersion = '';

  Future<void> fetchAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  bool areChangePasswordNewConfirmMatch() => cpConfirmController.text == cpNewController.text;

  bool areChangePasswordFieldsEmpty() =>
      cpConfirmController.text.isNotEmpty && cpNewController.text.isNotEmpty && cpOldController.text.isNotEmpty;

  void clearChangePasswordControllers() {
    cpConfirmController.clear();
    cpOldController.clear();
    cpNewController.clear();
  }
}
