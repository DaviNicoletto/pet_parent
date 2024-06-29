import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/firestore_db.dart';
import 'package:pet_parent/src/views/home_view.dart';

import '../widgets/dialog_message.dart';

class DBAuth extends ChangeNotifier {
  DBAuth() {
    _authCheck();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudDatabase firebaseDB = CloudDatabase();
  User? loggedUser;
  bool isLoading = true;

  AppConstants constants = AppConstants();

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      loggedUser = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return constants.existingUser;
      case 'invalid-email':
        return constants.invalidEmailAdress;
      case 'invalid-credential':
        return constants.incorrectLogin;
      default:
        return '${constants.authenticationError}: $code';
    }
  }

  Future<void> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uId = userCredential.user!.uid;

      if (context.mounted) {
        firebaseDB.createUser(name, email, password, context, uId);
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                  title: constants.success,
                  message: constants.userRegistered,
                  buttonText: constants.login,
                  buttonRoute: '/login',
                ));
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                  title: constants.error,
                  message: _getErrorMessage(e.code),
                  buttonRoute: '',
                  buttonText: '',
                ));
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                  title: constants.error,
                  message: _getErrorMessage(e.toString()),
                  buttonRoute: '',
                  buttonText: '',
                ));
      }
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required email,
      required password,
      required BuildContext context}) async {
    try {
      // ignore: unused_local_variable
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                  title: constants.error,
                  message: _getErrorMessage(e.code),
                  buttonRoute: '',
                  buttonText: '',
                ));
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                  title: constants.error,
                  message: _getErrorMessage(e.toString()),
                  buttonRoute: '',
                  buttonText: '',
                ));
      }
    }
  }
}
