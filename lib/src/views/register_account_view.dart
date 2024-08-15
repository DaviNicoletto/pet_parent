import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/widgets/auth/form_register_user.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final AppConstants constants = AppConstants();
  final AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/pp_logo.png',
              alignment: Alignment.center,
              width: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    constants.register,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inika(
                        textStyle: TextStyle(
                            color: colors.colorHighlight, fontSize: 30)),
                  ),
                ),
                const SizedBox(height: 30),
                const RegisterForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
