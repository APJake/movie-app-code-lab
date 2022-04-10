import 'package:intl/intl.dart';

class UseMe {
  static String getDateString(DateTime? date) =>
      date == null ? "" : DateFormat("d MMMM y").format(date);

  static String minutesToReadableTimeString(int minutes) {
    String timeString = "";
    int hour = (minutes / 60).floor();
    if (hour > 0) {
      timeString += "${hour}h ";
    }
    int minute = minutes % 60;
    timeString += "${minute}min";
    return timeString;
  }
}
