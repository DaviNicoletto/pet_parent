import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class FieldForm extends StatefulWidget {
  const FieldForm(
      {super.key,
      required this.label,
      required this.controller,
      required this.isPassword,
      required this.isEmail,
      required this.isRequired});

  final String label;
  final bool isPassword;
  final bool isEmail;
  final bool isRequired;
  final TextEditingController controller;

  @override
  State<FieldForm> createState() => _FieldFormState();
}

class _FieldFormState extends State<FieldForm> {
  late bool isHidden = widget.isPassword;
  FormConstants constants = FormConstants();

  @override
  Widget build(BuildContext context) {
    AppColors colors = AppColors();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextFormField(
        obscureText: isHidden,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: isHidden
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                )
              : null,
          labelText: widget.label,
          labelStyle: GoogleFonts.inika(
            textStyle: TextStyle(color: colors.colorTextDark, fontSize: 15),
          ),
        ),
        validator: (value) {
          if (value != null) {
            if (widget.isRequired && value.isEmpty) {
              return ("Campo obrigatório.");
            }
            if(widget.label == constants.ageField && int.tryParse(value) == null){
              return ("Idade inválida.");
            }
            if (widget.isPassword == true) {
              if (value.length < 5) {
                return ('Mínimo de 5 caracteres!');
              }
            }
            if (widget.isEmail == true && !value.contains("@")) {
              return ('E-mail inválido!');
            }
          }
          return null;
        },
      ),
    );
  }
}
