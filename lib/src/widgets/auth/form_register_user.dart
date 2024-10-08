import 'package:flutter/material.dart';
import 'package:pet_parent/src/widgets/common/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/auth_service.dart';

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

    bool isPassword = true;

    void save() async {
      final isValid = formKey.currentState?.validate();
      DBAuth firebaseAuth = DBAuth();

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
              isRequired: true,
            ),
            FieldForm(
              label: 'E-mail',
              controller: controllerEmail,
              isPassword: false,
              isEmail: true,
              isRequired: true,
            ),
            FieldForm(
              label: fieldName.passwordField,
              controller: controllerPassword,
              isPassword: isPassword,
              isEmail: false,
              isRequired: true,
            ),
            ElevatedButton(
              onPressed: save,
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry?>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor:
                    WidgetStatePropertyAll<Color>(colors.colorPrimary),
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
