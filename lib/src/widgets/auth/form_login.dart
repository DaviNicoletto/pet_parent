import 'package:flutter/material.dart';
import 'package:pet_parent/src/widgets/common/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/auth_service.dart';

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
    GlobalKey<FormState> formKey = GlobalKey();
    DBAuth authentication = DBAuth();


    void login() async {
      final isValid = formKey.currentState?.validate();

      if (isValid == false) {
        return;
      }

      await authentication.loginWithEmailAndPassword(email: controllerEmail.text,
        password: controllerPassword.text, context: context); 

      formKey.currentState?.save();

    }

    return Center(
      child: SingleChildScrollView(
          child: Form(
        key: formKey,
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