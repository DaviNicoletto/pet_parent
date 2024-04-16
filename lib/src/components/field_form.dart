import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class FieldForm extends StatelessWidget {
  const FieldForm(
      {super.key,
      required this.label,
      required this.controller,
      required this.isPassword,
      required this.isEmail});

  final String label;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    AppColors colors = AppColors();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelStyle: TextStyle(
            color: colors.colorTextDark,
            backgroundColor: Colors.white,
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: GoogleFonts.inika(
            textStyle: TextStyle(color: colors.colorTextDark, fontSize: 20),
          ),
        ),
        validator: (value){
          if (value!.length < 5){
            return('Mínimo de 5 caracteres!');
          }
          if (this.isEmail == true && !value.contains("@")){
            return('E-mail inválido!');
          }
        },
      ),
    );
  }
}
