import 'package:flutter/material.dart';

import 'models/user_model.dart';

class UserProvider extends InheritedWidget {
  UserProvider({super.key, required this.child}) : super(child: child);

  @override
  final Widget child;
  final List<User> users = [];

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }
}