import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/widgets/field_form.dart';

import '../services/firestore_db.dart';

class PetModal extends StatefulWidget {
  const PetModal({super.key});

  @override
  State<PetModal> createState() => _PetModalState();
}

class _PetModalState extends State<PetModal> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameControllerPet = TextEditingController();
  TextEditingController _ageControllerPet = TextEditingController();
  TextEditingController _breedControllerPet = TextEditingController();
  TextEditingController _typeControllerPet = TextEditingController();
  TextEditingController _colorControllerPet = TextEditingController();
  TextEditingController _genderControllerPet = TextEditingController();
  TextEditingController _SNControllerPet = TextEditingController();

  AppColors colors = AppColors();
  AppConstants constants = AppConstants();
  FormConstants formConstants = FormConstants();

  CloudDatabase db = CloudDatabase();
  DBAuth auth = DBAuth();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                int age = int.parse(_ageControllerPet.text);
                String? uId = await auth.getLoggedUserId();
                db.addNewPet(
                    context,
                    _nameControllerPet.text,
                    _genderControllerPet.text,
                    age,
                    _colorControllerPet.text,
                    _SNControllerPet.text,
                    _breedControllerPet.text,
                    uId);
              }
            },
            child: Text(
              constants.add,
              style: TextStyle(color: colors.colorPrimary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              constants.goBack,
              style: TextStyle(color: colors.colorPrimary),
            ),
          ),
        ],
        title: Text(constants.add),
        contentPadding: const EdgeInsets.all(15.0),
        content: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FieldForm(
                      label: formConstants.nameField,
                      controller: _nameControllerPet,
                      isPassword: false,
                      isEmail: false),
                  FieldForm(
                      label: formConstants.ageField,
                      controller: _ageControllerPet,
                      isPassword: false,
                      isEmail: false),
                  FieldForm(
                      label: formConstants.breedField,
                      controller: _breedControllerPet,
                      isPassword: false,
                      isEmail: false),
                  FieldForm(
                      label: formConstants.genderField,
                      controller: _genderControllerPet,
                      isPassword: false,
                      isEmail: false),
                  FieldForm(
                      label: formConstants.colorField,
                      controller: _colorControllerPet,
                      isPassword: false,
                      isEmail: false),
                  FieldForm(
                      label: formConstants.SNField,
                      controller: _SNControllerPet,
                      isPassword: false,
                      isEmail: false),
                ],
              ),
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
