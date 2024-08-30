import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'appointment_model.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<AppointmentModel> source) {
    appointments = source.map((appointment) {
      DateTime endTimeDefault =
          appointment.startTime.add(const Duration(hours: 1, minutes: 30));
      return Appointment(
          startTime: appointment.startTime,
          endTime: appointment.endTime ?? endTimeDefault,
          subject: appointment.subject);
    }).toList();
  }
}
