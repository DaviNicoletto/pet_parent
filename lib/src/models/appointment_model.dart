import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final DateTime startTime;
  final DateTime? endTime;
  final String subject;

  AppointmentModel(
      {required this.startTime, this.endTime, required this.subject});

  toJson() {
    return {
      "StartTime": startTime,
      "EndTime": endTime,
      "Subject": subject,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
        startTime: (map["StartTime"] as Timestamp).toDate(),
        endTime: map["EndTime"] != null
            ? (map["EndTime"] as Timestamp).toDate()
            : (map["StartTime"] as Timestamp)
                .toDate()
                .add(const Duration(hours: 1, minutes: 30)),
        subject: (map["Subject"] ?? "Sem assunto"));
  }
}
