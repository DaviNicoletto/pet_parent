import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/components/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FormConstants constants = FormConstants();
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FieldForm(
            label: constants.nameField,
            controller: controllerName,
            isPassword: false,
          ),
          FieldForm(
            label: 'E-mail',
            controller: controllerEmail,
            isPassword: false,
          ),
          FieldForm(
            label: constants.passwordField,
            controller: controllerPassword,
            isPassword: true,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                constants.submmitForm,
                style: TextStyle(color: colors.colorPrimary),
              ))
        ],
      ),
    );
  }
}
