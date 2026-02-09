// Dart imports:
import 'dart:math';

// Package imports:
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // This will return first the day of week in the month
  DateTime get firstDayOfWeek => subtract(Duration(days: weekday - 1)).startOfDay;

  // This will return last the day of week in the month
  DateTime get lastDayOfWeek {
    var lastDay = add(Duration(days: DateTime.daysPerWeek - weekday)).endOfDay;
    if (lastDay.hour == 0 && lastDay.minute == 59 && lastDay.second == 59) {
      lastDay = lastDay.subtract(const Duration(hours: 1));
    }
    return lastDay;
  }

  // This will return days count of difference between 2 dates
  int daysFrom(DateTime date) {
    return difference(date).inDays;
  }

  // This will return the day of week with sunday as the 1st day of week.
  int get peakDayOfWeek => weekday;

  // This will return Date of first day of month, while preserving the time zone information.
  DateTime get startOfMonth {
    var dt = subtract(Duration(days: day - 1)).startOfDay;
    if (dt.day != 1) {
      dt = dt.subtract(Duration(days: dt.day - 1));
    }
    return dt;
  }

  // This will return Date of last day of month
  DateTime get endOfMonth {
    var dt = add(Duration(days: daysInMonth(this) - day)).endOfDay;
    if (dt.day != daysInMonth(dt)) {
      dt = dt.add(Duration(days: daysInMonth(this) - dt.day));
    }
    return dt;
  }

  // This will return Date by adding months count
  DateTime dateByAddingMonths(int months, DateTime Function(DateTime dt) timezoneConversionFunction) {
    final modMonths = months % 12;
    var newYear = year + ((months - modMonths) ~/ 12);
    var newMonth = month + modMonths;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(day, daysInMonth(DateTime(newYear, newMonth)));
    var date2 = DateTime(newYear, newMonth, newDay, hour, minute, second, millisecond, microsecond);
    date2 = timezoneConversionFunction(date2);
    final difference = date2.difference(this).inHours;
    var newDate = add(Duration(hours: difference));
    return newDate;
  }

  int daysInMonth(DateTime date) {
    if (date.month == 1 ||
        date.month == 3 ||
        date.month == 5 ||
        date.month == 7 ||
        date.month == 8 ||
        date.month == 10 ||
        date.month == 12) {
      return 31;
    } else if (date.month == 2) {
      if (isLeapYear(date.year)) {
        return 29;
      } else {
        return 28;
      }
    } else {
      return 30;
    }

    // var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    // var firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    // return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  int daysInYear(int year) {
    return DateTime(year + 1, 0).difference(DateTime(year, 0)).inDays;
  }

  // This will return Date by adding days count
  DateTime dateByAddingDays(int num) {
    return add(Duration(days: num));
  }

  // This will return Date by adding minutes count
  DateTime dateByAddingMinutes(int num) {
    return add(Duration(minutes: num));
  }

  // This will return DateTime of beginning of the day (00:00:00)
  DateTime get startOfDay {
    return subtract(
        Duration(hours: hour, minutes: minute, seconds: second, milliseconds: millisecond, microseconds: microsecond));
  }

  // This will return DateTime of end of the day (23:59:59)
  DateTime get endOfDay {
    var result = add(Duration(
        hours: 23 - hour,
        minutes: 59 - minute,
        seconds: 59 - second,
        milliseconds: -millisecond,
        microseconds: -microsecond));

    if (result.hour == 0 && result.minute == 59 && result.second == 59) {
      result = result.add(const Duration(hours: -1));
    }
    return result;
  }

  // This will return DateTime without timestamp
  DateTime get dateWithoutTimeComponents {
    return startOfDay;
  }

  // This will return minutes difference from a particuler date
  int minutesFrom(DateTime dateTime) {
    return dateTime.difference(this).inMinutes;
  }

  // This will return seconds difference from a particuler date
  int secondsFrom(DateTime dateTime) {
    return dateTime.difference(this).inSeconds;
  }

  bool isDateToday(DateTime timezoneAdjustedNow) {
    if (timezoneAdjustedNow.year == year && timezoneAdjustedNow.month == month && timezoneAdjustedNow.day == day) {
      return true;
    }
    return false;
  }

  bool isDateYesterday(DateTime timezoneAdjustedNow) {
    var yesterday = timezoneAdjustedNow.subtract(const Duration(days: 1));
    if (yesterday.year == year && yesterday.month == month && yesterday.day == day) {
      return true;
    }
    return false;
  }

  DateTime get midnightUtc {
    var dt = this;
    if (!isUtc) {
      dt = dt.toUtc();
    }
    return DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0);
  }

  String get monthShortName {
    return DateFormat.MMM().format(this);
  }

  String get monthLongName {
    return DateFormat.MMMM().format(this);
  }

  String get monthLongNameAndDay {
    return DateFormat('MMMM d').format(this);
  }

  String get formattedDate {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  String getFormattedDate({String format = 'M/dd/yyyy'}) {
    return DateFormat(format).format(this);
  }

  String get formattedTime {
    return DateFormat('h:mm aa').format(this);
  }

  String get formattedTime24H {
    return DateFormat('hh:mm a').format(this);
  }

  bool isLeapYear(int year) {
    // Every year divisible by 4 is a leap year,
    // except for years divisible by 100,
    // unless it's also divisible by 400
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
