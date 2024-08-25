class Appointment {
  final DateTime startTime;
  final DateTime? endTime;
  final String subject;

  Appointment(
      {required this.startTime, this.endTime, required this.subject});

  toJson() {
    return {
      "StartTime": startTime,
      "EndTime": endTime,
      "Subject": subject,
    };
  }
}
