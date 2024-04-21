import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

import '../models/user_model.dart';

class CloudDatabase {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Future<void> createUser (name, email, password) async {
  User user = User(name: name, email: email, password: password);
  Map<String, dynamic> userData = user.toJson();
  AppConstants constants = AppConstants();

  try{
    await _firestoreDB.collection('users').add(userData);
  }catch (e){
    print(constants.generalError);
  }


  }
}