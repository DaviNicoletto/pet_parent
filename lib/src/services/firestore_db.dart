import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:pet_parent/src/widgets/common/dialog_message.dart';
import '../models/pet_model.dart';
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

class CloudDatabase extends ChangeNotifier {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Future<void> createUser(name, email, password, context, userId) async {
    User user = User(name: name, email: email, password: password);
    Map<String, dynamic> userData = user.toJson();
    AppConstants constants = AppConstants();

    try {
      await _firestoreDB.collection('users').doc(userId).set(userData);
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

  Future<void> addNewAppointment(context) async {
    Navigator.of(context).pop();
  }

  Future<void> addNewPet(
      context, name, gender, age, color, SP, breed, userId) async {
    AppConstants constants = AppConstants();
    print('addNewPet');

    Pet pet = Pet(
        name: name,
        age: age,
        breed: breed,
        color: color,
        gender: gender,
        specialNecessities: SP);
    Map<String, dynamic> petData = pet.toJson();

    try {
      await _firestoreDB
          .collection("users")
          .doc(userId)
          .collection("pets")
          .doc(pet.name)
          .set(petData);
      Navigator.of(context).pop();
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

  Stream<List<Pet>> streamPets(BuildContext context, String? userId) {
    final petsCollection =
        _firestoreDB.collection('users').doc(userId).collection("pets");

    return petsCollection.snapshots().map((querySnapshot) {
      List<Pet> userPets = [];
      for (var docSnapshot in querySnapshot.docs) {
        List petData = docSnapshot.data().values.toList();
        Pet pet = Pet(
            name: petData[5],
            gender: petData[3],
            breed: petData[0],
            color: petData[1],
            age: petData[4],
            specialNecessities: petData[2],
            schedule: []);
        // print(pet.toJson());
        // print(petData);
        userPets.add(pet);
      }
      print("PEGOU OS PETS");
      print('LISTA DOS PETS: $userPets');
      return userPets;
    });
  }

  Future<List<Pet>> getUserPets(String? userId) async {
    final petsCollection =
        _firestoreDB.collection('users').doc(userId).collection("pets");

    try {
      QuerySnapshot querySnapshot = await petsCollection.get();
      List<Pet> documents = querySnapshot.docs.map((doc) {
        return Pet.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print("pegou os pets: $documents");
      return documents;
    } catch (e) {
      print("Erro no metodo getUserPets: $e");
      return [];
    }
  }

  Stream<List<Pet>> streamTasks(BuildContext context, String? userId) {
    final petsCollection =
        _firestoreDB.collection('users').doc(userId).collection("pets");

    return petsCollection.snapshots().map((querySnapshot) {
      List<Pet> userPets = [];
      for (var docSnapshot in querySnapshot.docs) {
        List petData = docSnapshot.data().values.toList();
        Pet pet = Pet(
            name: petData[5],
            gender: petData[3],
            breed: petData[0],
            color: petData[1],
            age: petData[4],
            specialNecessities: petData[2]);
        // print(pet.toJson());
        // print(petData);
        userPets.add(pet);
      }
      print("PEGOU OS PETS");
      print('LISTA DOS PETS: $userPets');
      return userPets;
    });
  }
}
