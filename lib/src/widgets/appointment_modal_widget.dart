import 'package:flutter/material.dart';
import 'package:pet_parent/src/services/firestore_db.dart';

import '../constants/app_constants.dart';

class AppointmentModal extends StatefulWidget {
  const AppointmentModal({super.key});

  @override
  State<AppointmentModal> createState() => AppointmentModalState();
}

class AppointmentModalState extends State<AppointmentModal> {
  @override
Widget build(BuildContext context) {

    AppColors colors = AppColors();
    AppConstants constants = AppConstants();

    CloudDatabase db = new CloudDatabase();

   
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            db.addNewAppointment(context);
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
      content:  SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: const Column(
          
        )),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

}