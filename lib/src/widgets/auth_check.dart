import 'package:flutter/material.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/views/onboarding_view.dart';
import 'package:provider/provider.dart';

import '../views/home_view.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    DBAuth auth = Provider.of<DBAuth>(context);

    if(auth.isSignedIn){
      return HomePage();
    } if (auth.isSignedIn) {
      return FirstAcessPage();
    }

    if (auth.isLoading) {
      return loading();
    } else if (auth.loggedUser == null) {
      return const FirstAcessPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
