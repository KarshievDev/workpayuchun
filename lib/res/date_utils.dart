import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';


DateTime getDateTimeFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

Future<Duration?> getSyncDuration() async {
  final second =  await SharedUtil.getValue(breakTime);
  final duration = second != null ? getDuration(int.parse(second)) : null;
  return duration;
}

///return duration from current date time(by difference)
///we get how many days hours minutes seconds spanned from now
Duration getDuration(int timestamp) {
  var now = DateTime.now();
  var date = getDateTimeFromTimestamp(timestamp);
  return now.difference(date);
}
String get24HTime({String format = 'HH:mm', required String? timeOfDay}) {
  if (timeOfDay == null) return '';

  try {
    // Try to parse as 12-hour format (e.g., "5:30 PM")
    final DateTime parsedTime = DateFormat.jm().parse(timeOfDay);
    return DateFormat(format).format(parsedTime);
  } catch (e) {
    // If that fails, assume it's in 24-hour format (e.g., "17:16")
    try {
      final DateTime parsedTime = DateFormat('HH:mm').parse(timeOfDay);
      return DateFormat(format).format(parsedTime);
    } catch (e) {
      // If parsing fails for both, return an empty string or handle the error
      return '';
    }
  }
}

bool isStartTimeBeforeEndTime(TimeOfDay startTime, TimeOfDay endTime) {
  final int startMinutes = startTime.hour * 60 + startTime.minute;
  final int endMinutes = endTime.hour * 60 + endTime.minute;
  return startMinutes < endMinutes;
}