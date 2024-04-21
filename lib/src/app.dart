import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/user_provider.dart';
import 'package:pet_parent/src/views/onboarding_view.dart';
import 'package:pet_parent/src/views/home_view.dart';
import 'package:pet_parent/src/views/login_view.dart';
import 'package:pet_parent/src/views/register_account_view.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    final AppConstants appConstants = AppConstants(); 
    return UserProvider(
      child: MaterialApp(
        title: appConstants.appTitle,
        initialRoute: '/',
        routes:{
          '/' : (context) => const FirstAcessPage(),
          '/register' : (context) => const RegisterUserPage(),
          '/login' : (context) => const LoginPage(),
          '/home' : (context) => const HomePage(),
        },
      ),
    );
  }
}