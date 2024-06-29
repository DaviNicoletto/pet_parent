import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.constants,
    required this.child,
  });

  final AppConstants constants;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
