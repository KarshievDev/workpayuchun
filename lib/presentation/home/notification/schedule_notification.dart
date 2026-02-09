
import 'package:easy_localization/easy_localization.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/service/notification_service.dart';

void checkInScheduleNotification(List<CheckTime> startTime, List<CheckTime> endTime) async {
  ///unsubscribe * previous subscription if any
  await notificationPlugin.unSubscribeScheduleAll();
  final formatter = DateFormat('yyyy-MM-dd hh:mm');

  /// Schedule the notification
  ///looping all schedule and set that schedule as active
  for (var inTime in startTime) {
    DateTime dateTime = formatter.parse(inTime.date);

    /// Extract date and time components
    int day = dateTime.day;
    int year = dateTime.year;
    int month = dateTime.month;
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    /// Schedule the notification
    await notificationPlugin.scheduleNotification(
      id: inTime.id,
      title: "Check In Alert",
      body: "good_morning_have_you_checked_in".tr(),
      day: day,
      year: year,
      month: month,
      hour: hour,
      minute: minute,
      second: 0,
    );
  }
  for (var outTime in endTime) {
    DateTime dateTime = formatter.parse(outTime.date);

    /// Extract date and time components
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int year = dateTime.year;
    int month = dateTime.month;

    /// Schedule the notification
    await notificationPlugin.scheduleNotification(
      id: outTime.id,
      title: "Check Out Alert",
      body: "good_evening_have_you_checked_out".tr(),
      day: day,
      year: year,
      month: month,
      hour: hour,
      minute: minute,
      second: 0,
    );
  }
}

