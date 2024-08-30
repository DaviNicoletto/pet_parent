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

  List<AppointmentModel> appointments = [];

  void _getAppointments() async {
    try {
      final String? uId = await _getUId();

      if (uId != null) {
        final fetchedAppointments = await db.getAllPetsAppointments(uId);
        print("fetchedTasks: $fetchedAppointments");
        setState(() {
          appointments = fetchedAppointments;
        });

        print("appointments pegos: ${appointments}");
        appointments.forEach((element) {
          print(element);
        });
      } else
        (print("O usuário não está logado. uId = null"));
    } catch (e) {
      print("Erro ao buscar compromissos: $e");
    }
  }

  @override
  void initState() {
    _getAppointments();
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
      dataSource: AppointmentDataSource(appointments),
    );
  }
}
