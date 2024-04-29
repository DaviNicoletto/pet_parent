import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppConstants constants = AppConstants();
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: Text(
          constants.homePageTitle,
          style: TextStyle(color: colors.colorTextLight),
        ),
      ),
      body: const Center(
        child: Text('Página inical!'),
      ),
    );
  }
}
