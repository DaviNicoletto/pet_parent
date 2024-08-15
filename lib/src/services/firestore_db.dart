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

class CloudDatabase {
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

  Future<List<Pet>> listPets(BuildContext context, String? userId) async {

    AppConstants constants = AppConstants();

    final petsCollection =
        _firestoreDB.collection('users').doc(userId).collection("pets");

    List<Pet> userPets = [];
    int petIndex = 0;

    try {
      await petsCollection.get().then((querySnapshot) {
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
          userPets.insert(petIndex, pet);
          petIndex++;
        }
        print("PEGOU OS PETS");
        print('LISTA DOS PETS: ${userPets}');
        return userPets;
      });
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
    return userPets;
  }
}
