import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/widgets/appointment_modal_widget.dart';
import 'package:pet_parent/src/widgets/custom_navigation_bar.dart';
import '../constants/app_constants.dart';
import '../widgets/section_container.dart';
import '../widgets/calendar_widget.dart';

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
            style: GoogleFonts.inika(
                textStyle: const TextStyle(color: Colors.white)),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ]),
      body: Center(
        child: Column(
          children: [
            SectionContainer(
              constants: constants,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    constants.mySchedule,
                    style: GoogleFonts.inika(
                      textStyle: TextStyle(fontSize: constants.titleFontSize),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CalendarWidget(),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const AppointmentModal());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                            colors.colorHighlight),
                            
                          ),
                          child: const Text("+", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300)),
                                        ),
                    )
              )],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
