import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/firestore_db.dart';

import '../components/dialog_message.dart';

class DBAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudDatabase firebaseDB = CloudDatabase();
  AppConstants constants = AppConstants();

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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        firebaseDB.createUser(name, email, password, context);
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
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
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
