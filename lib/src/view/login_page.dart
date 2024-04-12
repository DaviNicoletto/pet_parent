import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AppConstants constants = AppConstants();

  final colorHighlight = Color(0xFFFF9934);
  final colorSecondary = Color(0xFFE1F1F2);
  final colorPrimary = Color(0xFF2CBBC3);
  final colorTextLight = Color(0xFFF9F9F9);
  final colorTextDark = Color(0xFF101010);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorPrimary),
      ),
      body: Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(color: colorHighlight),
        child: Column(
        ),
      ),
    );
  }
}
