import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class FieldForm extends StatelessWidget {
  FieldForm(
      {super.key,
      required this.label,
      required this.controller,
      required this.isPassword});

  String label;
  bool isPassword;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
  
    AppColors colors = AppColors();
  
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: GoogleFonts.inika(
           textStyle: TextStyle(color: colors.colorPrimary,fontSize: 20),
          )
          ,
        ),
      ),
    );
  }
}
