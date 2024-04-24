import 'package:flutter/material.dart';
import 'package:pet_parent/src/components/dialog_message.dart';
import 'package:pet_parent/src/components/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/firebase_auth.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FormConstants fieldName = FormConstants();
  AppConstants constants = AppConstants();
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    void save() async {
      final isValid = formKey.currentState?.validate();
      DBAuth firebaseAuth = DBAuth();

      final BuildContext currentContext = context;

      if (isValid == false) {
        return;
      }

      await firebaseAuth.registerWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
        name: controllerName.text,
        context: context,
      );

    }

    return Center(
      child: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Column(
          children: [
            FieldForm(
              label: fieldName.nameField,
              controller: controllerName,
              isPassword: false,
              isEmail: false,
            ),
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
              onPressed: save,
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
