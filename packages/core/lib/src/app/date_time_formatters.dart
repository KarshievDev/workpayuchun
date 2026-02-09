import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDateAsString({DateTime? dateTime, String format = 'MM-dd-yyyy'}) {
  return DateFormat(format).format(dateTime!).toString();
}

DateTime? getFormattedDateTime({required String date, String format = 'MM-dd-yyyy'}) {
  try {
    DateFormat formatter = DateFormat(format);
    return date != 'N/A' ? formatter.parse(date) : null;
  } on FormatException catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

String getDateddMMMyyyyString({DateTime? dateTime}) {
  return dateTime != null ? DateFormat('dd MMM yyyy').format(dateTime).toString() : '';
}

String? getDDMMYYYYAsString(
    {required String date, String outputFormat = 'yyyy-mm-dd', String inputFormat = 'dd-mm-yyyy'}) {
  try {
    DateFormat formatter = DateFormat(inputFormat);
    DateFormat outputFormatter = DateFormat(outputFormat);
    return outputFormatter.format(formatter.parse(date));
  } on FormatException catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

String getTimeAmPm(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime).toString();
}

String? timeDifference({String? time1, String? time2, String format = 'hh:mm a'}) {
  if (time1 == null || time2 == null) return null;

  DateFormat formatter = DateFormat(format);
  final timeDate1 = formatter.parse(time1);
  var timeDate2 = formatter.parse(time2);

  // If timeDate2 is earlier than timeDate1, assume it is on the next day
  if (timeDate2.isBefore(timeDate1)) {
    timeDate2 = timeDate2.add(Duration(days: 1));
  }

  final duration = timeDate2.difference(timeDate1);

  return '${duration.inHours.abs().toString().padLeft(2, '0')}:${(duration.inMinutes.remainder(60).abs()).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60).abs()).ceil().toString().padLeft(2, '0')}';
}

TimeOfDay getTimeOfDayFromDateTime({String? time, String format = 'hh:mm A'}) {
  if (time == null) return TimeOfDay.fromDateTime(currentDate());
  final date = getDateTimeFromTime(time: time, format: format);
  return TimeOfDay.fromDateTime(date ?? currentDate());
}


DateTime? getDateTimeFromTime({String? time, String format = 'hh:mm A'}) {
  if (time == null) return null;
  DateFormat formatter = DateFormat(format);
  return formatter.parse(time);
}

DateTime getDateTimeFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

///return duration from current date time(by difference)
///we get how many days hours minutes seconds spanned from now
Duration getDuration(int timestamp) {
  var now = DateTime.now();
  var date = getDateTimeFromTimestamp(timestamp);
  return now.difference(date);
}

List<int> normalizeSeconds(int seconds) {
  int days = seconds ~/ TimeConstants.secondsPerDay;
  seconds -= days * TimeConstants.secondsPerDay;
  int hours = seconds ~/ TimeConstants.secondsPerHour;
  seconds -= hours * TimeConstants.secondsPerHour;
  int minutes = seconds ~/ TimeConstants.secondPerMinute;
  seconds -= minutes * TimeConstants.secondPerMinute;
  return [days, hours, minutes, seconds];
}

DateTime currentDate() {
  return DateTime.now();
}
