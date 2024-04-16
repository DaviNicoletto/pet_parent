import 'package:flutter/material.dart';
import 'package:pet_parent/src/components/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/models/user_model.dart';
import 'package:pet_parent/src/user_provider.dart';

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

    GlobalKey<FormState> _formKey = GlobalKey();

    void save() {

      final isValidade = _formKey.currentState?.validate();

      if (isValidade == false){
        return;
      }

      _formKey.currentState?.save();

      UserProvider userProvider = UserProvider.of(context) as UserProvider;

      User user = User(
          name: controllerName.text,
          email: controllerEmail.text,
          password: controllerPassword.text);

      userProvider.users.insert(0, user);


    }

    return Center(
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                        children: [
              FieldForm(
                label: constants.nameField,
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
                label: constants.passwordField,
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
                  constants.submmitForm,
                  style: TextStyle(color: colors.colorSecondary),
                ),
              )
                        ],
                      ),
            )),
      );
  }
}
