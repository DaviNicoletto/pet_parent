import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/models/appointment_model.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';
import 'package:pet_parent/src/widgets/pets_page/add_pet_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class customAppBar extends StatefulWidget implements PreferredSizeWidget {
  const customAppBar({super.key, required this.indexTitle});

  final int indexTitle;

  @override
  State<customAppBar> createState() => customAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

AppConstants constants = AppConstants();

final indexTitles = [
  constans.homePageTitle,
  constants.petsPageTitle,
  constants.servicesPageTitle,
  constants.profilePageTitle
];

class customAppBarState extends State<customAppBar> {
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<DBAuth>(context, listen: false);
    final CloudDatabase db = CloudDatabase();

    return AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          indexTitles[widget.indexTitle],
          style: GoogleFonts.inika(
              textStyle: const TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () async {
            String? uId = await auth.getLoggedUserId();
            List<AppointmentModel> teste = await db.getAllPetsAppointments(uId);
          }, icon: const Icon(Icons.bug_report_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                auth.logOutUser(context);
              },
              icon: const Icon(Icons.logout)),
        ]);
  }
}
