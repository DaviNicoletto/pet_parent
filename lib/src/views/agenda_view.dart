import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/views/home_view.dart';

import '../widgets/appointment_modal_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/section_container.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({
    super.key,
    required this.constants,
    required this.colors,
  });

  final AppConstants constants;
  final AppColors colors;

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SectionContainer(
            constants: widget.constants,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.constants.mySchedule,
                  style: GoogleFonts.inika(
                    textStyle:
                        TextStyle(fontSize: widget.constants.titleFontSize),
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
                      //TODO: Antes de montar o modal do form para task, criar o sistema de adicionar pets.
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => const AppointmentModal());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              widget.colors.colorHighlight),
                        ),
                        child: const Text("+",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w300)),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
