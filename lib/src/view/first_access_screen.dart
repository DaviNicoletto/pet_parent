import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class FirstAcessPage extends StatefulWidget {
  const FirstAcessPage({super.key});

  @override
  State<FirstAcessPage> createState() => FirstAcessPageState();
}

class FirstAcessPageState extends State<FirstAcessPage> {
  final AppConstants constants = new AppConstants();

  final colorHighlight = Color(0xFFFF9934);
  final colorSecondary = Color(0xFFE1F1F2);
  final colorPrimary = Color(0xFF2CBBC3);
  final colorTextLight = Color(0xFFF9F9F9);
  final colorTextDark = Color(0xFF101010);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(constants.appTitle),),
      body: const Column(
        children: [
          //Welcome
          Column(
            children: [

            ],
          ),
          //New User
          Column(

          ),
          //Login
          Column(

          )

        ],
      )
    );
  }
}