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
        subject: (map["Subject"] as String));
  }
}
