import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/components/field_form.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/database/petparent_db.dart';
import 'package:pet_parent/src/models/user_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FormConstants constants = FormConstants();
  AppColors colors = AppColors();

  Future<List<User>>? futureUsers;
  final petparentDB = PetparentDB();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();

    void save() async {
      final isValid = _formKey.currentState?.validate();

      if (isValid == false) {
        return;
      }

      _formKey.currentState?.save();

      final existingUser =
          await petparentDB.fetchUserByEmail(controllerEmail.text);

      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Este usuário já foi cadastrado!'),
        ));
        return;
      }

      petparentDB.registerUser(
          name: controllerName.text,
          password: controllerPassword.text,
          email: controllerEmail.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário registrado com sucesso!'),
        ),
      );
      Navigator.of(context).pushNamed('/');
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
