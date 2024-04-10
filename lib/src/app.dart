import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/view/first_access_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    final AppConstants appConstants = new AppConstants(); 
    return MaterialApp(
      title: appConstants.appTitle,
      home: FirstAcessPage(),
    );
  }
}