// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class FirstAcessPage extends StatefulWidget {
  const FirstAcessPage({super.key});

  @override
  State<FirstAcessPage> createState() => FirstAcessPageState();
}

class FirstAcessPageState extends State<FirstAcessPage> {
  final AppConstants constants = AppConstants();

  final AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            //Welcome
            Container(
              width: double.infinity,
              height: 340,
              padding: EdgeInsets.only(left: 35.0, bottom: 20, right: 50),
              decoration: BoxDecoration(color: colors.colorHighlight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(constants.welcome,
                      style: GoogleFonts.inika(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 30))),
                  Text(constants.appTitle,
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w700))),
                  Text(constants.appDescription,
                      style: GoogleFonts.inika(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20))),
                ],
              ),
            ),
            //New User
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.only(left: 35.0, bottom: 25, right: 50),
              decoration: BoxDecoration(color: colors.colorPrimary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(constants.registerTitle,
                      style: GoogleFonts.inika(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 25))),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacementNamed('/register');
                    },
                    child: Text(
                      constants.register,
                      style:
                          TextStyle(color: colors.colorPrimary, fontSize: 16),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          colors.colorSecondary),
                      overlayColor:
                          MaterialStatePropertyAll(colors.colorSecondary),
                    ),
                  ),
                ],
              ),
            ),

            //Login
            Container(
              width: double.infinity,
              height: 300,
              padding:
                  EdgeInsets.only(left: 35.0, bottom: 20, right: 50, top: 40),
              decoration: BoxDecoration(color: colors.colorSecondary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(constants.loginTitle,
                      style: GoogleFonts.inika(
                          textStyle: TextStyle(
                              color: colors.colorPrimary, fontSize: 25))),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text(
                      constants.login,
                      style:
                          TextStyle(color: colors.colorSecondary, fontSize: 16),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(colors.colorPrimary),
                      overlayColor:
                          MaterialStatePropertyAll(colors.colorHighlight),
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/pp_icon.png',
                    width: 100,
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
