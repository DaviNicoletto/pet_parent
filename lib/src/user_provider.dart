import 'package:flutter/material.dart';

import 'models/user_model.dart';

class UserProvider extends InheritedWidget {
  UserProvider({super.key, required super.child});


  final List<User> users = [];

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }
}