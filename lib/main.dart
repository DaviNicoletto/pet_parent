import 'package:flutter/material.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'src/app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => DBAuth()),],
    child: const MyApp(),
  ));
}