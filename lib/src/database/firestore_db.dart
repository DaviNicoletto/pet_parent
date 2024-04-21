import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class CloudDatabase {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Future<void> createUser (name, email, password) async {
  User user = User(name: name, email: email, password: password);
  Map<String, dynamic> userData = user.toJson();

  try{
    await _firestoreDB.collection('users').add(userData);
    print('usuario criado com sucesso');

  }catch (e){
    print('não foi possivel criar o usuario: $e');
  }


  }
}