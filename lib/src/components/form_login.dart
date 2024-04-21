import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_parent/src/components/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  AppConstants constants = AppConstants();
  FormConstants fieldName = FormConstants();
  AppColors colors = AppColors();


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
    DBAuth authentication = DBAuth();


    void login() async {
      final isValid = _formKey.currentState?.validate();

      if (isValid == false) {
        return;
      }

      await authentication.loginWithEmailAndPassword(email: controllerEmail.text,
        password: controllerPassword.text, context: context);

      // _formKey.currentState?.save();

      // final existingUser =
      //     await petparentDB.fetchUserByEmail(controllerEmail.text);

      // if (existingUser == null) {
      //   showDialog(
      //       context: context,
      //       builder: (context) => DialogMessage(
      //             title: constants.error,
      //             message: constants.userNotFound,
      //             buttonText: 'none',
      //             buttonRoute: 'none',
      //           ));
      //   return;
      // } else if (existingUser.email != controllerEmail.text ||
      //     existingUser.password != controllerPassword.text) {
      //   showDialog(
      //       context: context,
      //       builder: (context) => DialogMessage(
      //             title: constants.error,
      //             message: constants.incorrectLogin,
      //             buttonText: 'none',
      //             buttonRoute: 'none',
      //           ));
      //   return;
      // }

    }

    return Center(
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            FieldForm(
              label: 'E-mail',
              controller: controllerEmail,
              isPassword: false,
              isEmail: true,
            ),
            FieldForm(
              label: fieldName.passwordField,
              controller: controllerPassword,
              isPassword: true,
              isEmail: false,
            ),
            ElevatedButton(
              onPressed: login,
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll<EdgeInsetsGeometry?>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
                backgroundColor:
                    MaterialStatePropertyAll<Color>(colors.colorPrimary),
              ),
              child: Text(
                fieldName.submmitForm,
                style: TextStyle(color: colors.colorSecondary),
              ),
            )
          ],
        ),
      )),
    );
  }
}
