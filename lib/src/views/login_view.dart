import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/components/form_login.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppConstants constants = AppConstants();
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Text(
                      constants.login,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inika(
                          textStyle: TextStyle(
                              color: colors.colorHighlight, fontSize: 30)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const LoginForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
