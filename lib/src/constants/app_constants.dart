import 'package:flutter/material.dart';

class AppColors{
  Color get colorHighlight => Color(0xFFFF9934);
  Color get colorSecondary => Color(0xFFE1F1F2);
  Color get colorPrimary => Color(0xFF2CBBC3);
  Color get colorTextLight => Color(0xFFF9F9F9);
  Color get colorTextDark => Color(0xFF101010);
  Color get colorSuccess => Color.fromARGB(255, 59, 207, 84);
  Color get colorError => Color.fromARGB(255, 211, 22, 22);
}

class AppConstants {
  String get appTitle => 'Pet Parent';
  //First access page
  String get welcome => 'Bem vindo (a) ao';
  String get appDescription => 'A plataforma completa para todos os pais e mães de pet!';
  String get registerTitle => 'Primeira vez aqui?';
  String get register => 'Registrar nova conta';
  String get loginTitle => 'Se não, bem vindo de volta!';
  String get login => 'Entrar na conta';
}

class FormConstants {
  String get nameField => 'Nome';
  String get passwordField => 'Senha';
  String get submmitForm => 'Enviar';
}