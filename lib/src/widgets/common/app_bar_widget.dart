import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:provider/provider.dart';

class customAppBar extends StatefulWidget implements PreferredSizeWidget {
  const customAppBar({super.key});

  @override
  State<customAppBar> createState() => customAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class customAppBarState extends State<customAppBar> {
  AppConstants constants = AppConstants();
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
  final auth = Provider.of<DBAuth>(context, listen: false);
    return AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          constants.homePageTitle,
          style: GoogleFonts.inika(
              textStyle: const TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                auth.logOutUser(context);
              },
              icon: const Icon(Icons.logout)),
        ]);
  }
}
