import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/widgets/common/field_form.dart';

import '../../models/pet_model.dart';
import '../../services/firestore_db.dart';

class PetModal extends StatefulWidget {
  const PetModal({super.key});

  @override
  State<PetModal> createState() => _PetModalState();
}

final AppConstants constans = AppConstants();
final List<String> genderOptions = [
  constans.male,
  constans.female,
  constans.unknown
];

class _PetModalState extends State<PetModal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameControllerPet = TextEditingController();
  final TextEditingController _ageControllerPet = TextEditingController();
  final TextEditingController _breedControllerPet = TextEditingController();
  final TextEditingController _colorControllerPet = TextEditingController();
  TextEditingController _genderControllerPet = TextEditingController();
  final TextEditingController _SNControllerPet = TextEditingController();

  AppColors colors = AppColors();
  AppConstants constants = AppConstants();
  FormConstants formConstants = FormConstants();

  CloudDatabase db = CloudDatabase();
  DBAuth auth = DBAuth();
  String genderDropdownValue = '';

  List<Pet> petsList = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              constants.goBack,
              style: TextStyle(color: colors.colorError),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                int age = int.parse(_ageControllerPet.text);
                String? uId = await auth.getLoggedUserId();
                if (context.mounted) {
                  db.addNewPet(
                      context,
                      _nameControllerPet.text,
                      _genderControllerPet.text,
                      age,
                      _colorControllerPet.text,
                      _SNControllerPet.text,
                      _breedControllerPet.text,
                      uId);
                  db.streamPets(context, uId);
                }
              }
            },
            child: Text(
              constants.add,
              style: TextStyle(color: colors.colorPrimary),
            ),
          ),
        ],
        title: Text(constants.add),
        contentPadding: const EdgeInsets.all(15.0),
        content: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FieldForm(
                    label: formConstants.nameField,
                    controller: _nameControllerPet,
                    isPassword: false,
                    isEmail: false,
                    isRequired: true,
                  ),
                  FieldForm(
                    label: formConstants.ageField,
                    controller: _ageControllerPet,
                    isPassword: false,
                    isEmail: false,
                    isRequired: true,
                  ),
                  FieldForm(
                    label: formConstants.breedField,
                    controller: _breedControllerPet,
                    isPassword: false,
                    isEmail: false,
                    isRequired: true,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        underline: Container(
                          height: 0,
                        ),
                        hint: Text(constants.selectGender),
                        iconSize: 30,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        // iconEnabledColor: colors.colorPrimary,
                        focusColor: colors.colorPrimary,
                        style: GoogleFonts.inika(
                            textStyle: TextStyle(
                          fontSize: constants.textFontSize,
                          color: colors.colorTextDark,
                        )),
                        value: genderDropdownValue.isEmpty
                            ? null
                            : genderDropdownValue,
                        isExpanded: true,
                        items: genderOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            genderDropdownValue = value!;
                            _genderControllerPet.text = genderDropdownValue;
                          });
                        }),
                  ),
                  FieldForm(
                    label: formConstants.colorField,
                    controller: _colorControllerPet,
                    isPassword: false,
                    isEmail: false,
                    isRequired: false,
                  ),
                  FieldForm(
                    label: formConstants.SNField,
                    controller: _SNControllerPet,
                    isPassword: false,
                    isEmail: false,
                    isRequired: false,
                  ),
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
