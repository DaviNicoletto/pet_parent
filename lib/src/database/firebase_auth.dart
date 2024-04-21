import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/firestore_db.dart';

import '../components/dialog_message.dart';

class DBAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudDatabase firebaseDB = CloudDatabase();
  AppConstants constants = AppConstants();

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
      // Usuário criado com sucesso, você pode realizar outras operações aqui, como salvar dados do usuário no Firestore.
      firebaseDB.createUser(name, email, password);
      showDialog(
            context: context,
            builder: (context) => DialogMessage(
                title: constants.success,
                message: constants.userRegistered,
                buttonText: constants.login,
                buttonRoute: '/login'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                title: constants.error,
                message: constants.weakPassword,
                buttonText: '',
                buttonRoute: ''));
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                title: constants.error,
                message: constants.existingUser,
                buttonText: '',
                buttonRoute: ''));
        ;
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => DialogMessage(
              title: constants.error,
              message: constants.generalError,
              buttonText: '',
              buttonRoute: ''));
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required email,
      required password,
      required BuildContext context}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed('/home');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                title: constants.error,
                message: constants.generalError,
                buttonText: '',
                buttonRoute: ''));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showDialog(
            context: context,
            builder: (context) => DialogMessage(
                title: constants.error,
                message: constants.incorrectLogin,
                buttonText: '',
                buttonRoute: ''));
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) => DialogMessage(
              title: constants.error,
              message: constants.generalError,
              buttonText: '',
              buttonRoute: ''));
    }
    ;
  }
}
