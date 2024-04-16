import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/view/first_access_screen.dart';
import 'package:pet_parent/src/view/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    final AppConstants appConstants = AppConstants(); 
    return MaterialApp(
      title: appConstants.appTitle,
      initialRoute: '/',
      routes:{
        '/' : (context) => const FirstAcessPage(),
        '/login' : (context) => const LoginPage(),
      },
    );
  }
}