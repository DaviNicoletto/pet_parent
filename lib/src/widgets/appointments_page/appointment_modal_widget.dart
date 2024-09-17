import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';

import '../../constants/app_constants.dart';
import '../../models/pet_model.dart';
import '../common/field_form.dart';

class AppointmentModal extends StatefulWidget {
  const AppointmentModal({super.key});

  @override
  State<AppointmentModal> createState() => AppointmentModalState();
}

class AppointmentModalState extends State<AppointmentModal> {
  final _formKey = GlobalKey<FormState>();

  List<Pet?> petsList = [];
  CloudDatabase db = CloudDatabase();
  DBAuth auth = DBAuth();

  Future<String?> _getUId() async {
    String? uId = await auth.getLoggedUserId();
    return uId;
  }

  String petDropdownValue = '';

  @override
  void initState() {
    _getUId().then((uId) {
      db.getUserPets(uId).then((value) => setState(() {
            petsList = value;
          }));
    });
    super.initState();
  }

  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _petTaskCotroller = TextEditingController();
  final TextEditingController _taskDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppColors colors = AppColors();
    AppConstants constants = AppConstants();
    FormConstants formConstants = FormConstants();

    List petsNames = [];

    for (int i = 0; i < petsList.length; i++) {
      String petName = petsList[i]!.name;
      petsNames.add(petName);
    }

    Future<void> _selectDateTime(BuildContext context) async {
      final DateFormat _dateFormat = DateFormat("dd/MM/yyyy HH:mm");

      DateTime? selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
          locale: const Locale('pt', 'BR'));

      if(context.mounted){
      if (selectedDate != null) {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          final fullDateTimeSelected = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          _taskDateTimeController.text =
              _dateFormat.format(fullDateTimeSelected);
          print(_taskDateTimeController.text);
        }
      }
      }
    }

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
                String? uId = await auth.getLoggedUserId();

                if (context.mounted) {
                  db.addNewAppointment(context,
                  uId,
                  _taskTitleController.text,
                  _petTaskCotroller.text,
                  _taskDateTimeController.text);
                  db.streamTasks(context, uId, _petTaskCotroller.text);
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
                    label: formConstants.addTitle,
                    controller: _taskTitleController,
                    isPassword: false,
                    isEmail: false,
                    isRequired: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: TextFormField(
                              controller: _taskDateTimeController,
                              decoration: InputDecoration(
                                labelText: 'Data e Hora',
                                labelStyle: GoogleFonts.inika(
                                    textStyle: TextStyle(
                                  fontSize: constants.textFontSize,
                                  color: colors.colorTextDark,
                                )),
                                hintText: "Selecione a data",
                                suffixIcon: const Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: () => _selectDateTime(context)),
                        ),
                      ),
                    ],
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
                        hint: Text(constants.selectPet),
                        iconSize: 30,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        // iconEnabledColor: colors.colorPrimary,
                        focusColor: colors.colorPrimary,
                        style: GoogleFonts.inika(
                            textStyle: TextStyle(
                          fontSize: constants.textFontSize,
                          color: colors.colorTextDark,
                        )),
                        value:
                            petDropdownValue.isEmpty ? null : petDropdownValue,
                        isExpanded: true,
                        items: petsNames
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            petDropdownValue = value!;
                            _petTaskCotroller.text = petDropdownValue;
                          });
                        }),
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
