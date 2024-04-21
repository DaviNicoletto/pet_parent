import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/firestore_db.dart';


class DBAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudDatabase firebaseDB = CloudDatabase();
  AppConstants constants = AppConstants();

  Future<void> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Usuário criado com sucesso, você pode realizar outras operações aqui, como salvar dados do usuário no Firestore.
      firebaseDB.createUser(name, email, password);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        print('Email já cadastrado');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required email, required password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
