import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:pet_parent/src/widgets/dialog_message.dart';

import '../models/user_model.dart';


String _getErrorMessage(String code) {
  AppConstants constants = AppConstants();
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

class CloudDatabase {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Future<void> createUser (name, email, password, context, userId) async {
  User user = User(name: name, email: email, password: password);
  Map<String, dynamic> userData = user.toJson();
  AppConstants constants = AppConstants();

  try{
    await _firestoreDB.collection('users').doc(userId).set(userData);
  }catch (e){
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

  Future<void> addNewAppointment (context) async {
    Navigator.of(context).pop();
  }
}