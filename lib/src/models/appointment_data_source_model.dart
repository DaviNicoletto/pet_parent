import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'appointment_model.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<AppointmentModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  // Outros métodos que você precisar sobrescrever
}