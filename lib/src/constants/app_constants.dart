import 'package:flutter/material.dart';

class AppColors{
  Color get colorHighlight => const Color(0xFFFF9934);
  Color get colorSecondary => const Color(0xFFE1F1F2);
  Color get colorPrimary => const Color(0xFF2CBBC3);
  Color get colorTextLight => const Color(0xFFF9F9F9);
  Color get colorTextDark => const Color(0xFF101010);
  Color get colorSuccess => const Color.fromARGB(255, 59, 207, 84);
  Color get colorError => const Color.fromARGB(255, 211, 22, 22);
}

class AppConstants {

  //Font Sizes
  double get titleFontSize => 25;
  double get secondTitleFontSize => 20;
  double get textFontSize => 15;
  double get subTextFontSize => 10;
  
  //General Strings
  String get appTitle => 'Pet Parent';
  String get goBack => 'Voltar';
  String get success => 'Sucesso!';
  String get error => 'Erro';
  String get add => 'Adicionar';
  

  //Page Titles
  String get homePageTitle => 'Início';
  String get petsPageTitle => 'Meus pets';
  String get servicesPageTitle => 'Encontrar serviços';
  String get profilePageTitle => 'Perfil';

  //Onboarding page
  String get welcome => 'Bem vindo (a) ao';
  String get appDescription => 'A plataforma completa para todos os pais e mães de pet!';
  String get registerTitle => 'Primeira vez aqui?';
  String get register => 'Registrar nova conta';
  String get loginTitle => 'Se não, bem vindo de volta!';
  String get login => 'Entrar na conta';

  //Register user
  String get userRegistered => 'Usuário registrado com sucesso.';

  //Error Messages
  String get generalError => 'Ocorreu um erro, tente novamente.';
  String get incorrectLogin => 'E-mail ou senha incorretos.';
  String get existingUser => 'O E-mail inserido já está cadastrado.';
  String get weakPassword => 'A senha inserida não é forte o bastante.';
  String get invalidEmailAdress => 'O E-mail inserido é inválido.';
  String get authenticationError => 'Houve um erro de autenticação';

  //Home Page
  String get mySchedule => 'Minha agenda';
  

}

class FormConstants {
  String get nameField => 'Nome';
  String get passwordField => 'Senha';
  String get submmitForm => 'Enviar';
}