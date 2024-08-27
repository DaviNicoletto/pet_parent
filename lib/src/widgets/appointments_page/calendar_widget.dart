import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/models/appointment_data_source_model.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:pet_parent/src/models/appointment_model.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final AppColors color = AppColors();

  CloudDatabase db = CloudDatabase();
  DBAuth auth = DBAuth();

  Future<String?> _getUId() async {
    String? uId = await auth.getLoggedUserId();
    return uId;
  }

  //
//
//
//
//
// TODO: ALTERAR A FORMA DE PEGAR AS TASKS DO DB:
// pegar um array com as tasks de cada pet, e juntar em uma array de todos os pets para usar de datasource do calendario
// -sem stream-
//
//
//
//
//

  late List<AppointmentModel> petTasks = [];
  late CalendarDataSource dataSource;
  @override
  void initState() {
    _getUId().then((uId) async {
      if (uId != null) {
        petTasks = await db.getPetAppointments(uId, "Maze");
        dataSource = AppointmentDataSource(petTasks);
        print(dataSource);
        print(petTasks);
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      todayHighlightColor: color.colorHighlight,
      selectionDecoration: BoxDecoration(
          border: Border.all(color: color.colorPrimary, width: 1.5)),
      showTodayButton: true,
      showDatePickerButton: true,
    );
  }
}
