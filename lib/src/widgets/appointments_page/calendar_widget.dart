import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({super.key});

  final AppColors color = AppColors();

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      todayHighlightColor: color.colorHighlight,
      selectionDecoration: BoxDecoration(border: Border.all(color: color.colorPrimary, width: 1.5)),
      showTodayButton: true,
      showDatePickerButton: true,
      
   );
  }
}