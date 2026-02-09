import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/notification.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  InitializationSettings? initializationSettings;

  LocalNotificationService() {
    init();
  }

  init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    _initializePlatformSpecifies();
  }

  _initializePlatformSpecifies() {
    const initialAndroidSettings = AndroidInitializationSettings('fav_logo');

    final initialIosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async {
      //   ReceivedNotification receivedNotification =
      //       ReceivedNotification(id: id!, title: title!, body: body!, payload: payload!);
      //   didReceivedLocalNotificationSubject.add(receivedNotification);
      // }
    );

    initializationSettings = InitializationSettings(
      android: initialAndroidSettings,
      iOS: initialIosSettings,
    );
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: false, badge: false, sound: true);
  }

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
        '0',
        "Strawberry",
        channelDescription:
            "This channel is responsible for all the local notifications",
        playSound: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('alert_tones'),
        priority: Priority.high,
        importance: Importance.high,
      );
  static const DarwinNotificationDetails _iOSNotificationDetails =
      DarwinNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  setListenerForLowerVersion(Function onNotificationForLowerVersion) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationForLowerVersion(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      ReceivedNotification receivedNotification = ReceivedNotification(
        id: 0,
        title: '',
        body: '',
        payload: details.notificationResponse?.payload,
      );
      didReceivedLocalNotificationSubject.add(receivedNotification);
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings!,
      onDidReceiveNotificationResponse: (response) {
        onNotificationClick(response.payload);
        return;
      },
    );
  }

  ///regular notification
  Future<void> showNotification({title, body, payload}) async {
    const iosPlatformSpecifies = DarwinNotificationDetails();
    final androidChannelSpecifies = AndroidNotificationDetails(
      '0',
      "Strawberry",
      channelDescription:
          "This channel is responsible for all the local notifications",
      playSound: true,
      enableVibration: true,
      sound: const RawResourceAndroidNotificationSound('alert_tones'),
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
        htmlFormatBigText: true,
        htmlFormatSummaryText: true,
        htmlFormatContent: true,
      ),
      priority: Priority.high,
      importance: Importance.high,
    );

    final notificationDetails = NotificationDetails(
      android: androidChannelSpecifies,
      iOS: iosPlatformSpecifies,
    );

    await flutterLocalNotificationsPlugin.show(
      5,
      '$title',
      '$body',
      notificationDetails,
      payload: payload,
    );
  }

  Future initializeTimeZone() async {
    tz.initializeTimeZones();
  }

  ///scheduled notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int day,
    required int year,
    required int month,
    required int hour,
    required int minute,
    required int second,
  }) async {
    tz.initializeTimeZones();

    final now = DateTime.now();

    Duration offsetTime = now.timeZoneOffset;

    tz.TZDateTime tzDateLocalTime = tz.TZDateTime.local(
      year,
      month,
      day,
      hour,
      minute,
      second,
      0,
      0,
    );

    if (kDebugMode) {
      print('schedule year $year month $month day $day hour $hour min $minute');
    }

    if (kDebugMode) {
      print('schedule ID : $id');
    }

    if (kDebugMode) {
      print('Timezone name : ${tzDateLocalTime.timeZoneName}');
    }

    if (kDebugMode) {
      print('Local schedule time : ${tzDateLocalTime.toString()}');
    }

    if (kDebugMode) {
      print('Local current time : ${now.toString()}');
    }

    if (kDebugMode) {
      print(
        'offsetTime (Difference between local and UTC time) : ${offsetTime.toString()}',
      );
    }

    tz.TZDateTime tzDateTime = tzDateLocalTime.subtract(offsetTime);

    if (kDebugMode) {
      print('UTC TZDateTime : ${tzDateTime.toString()}');
    }

    if (tzDateTime.isBefore(now)) {
      tzDateTime = tzDateTime.add(const Duration(days: 1));
    }

    NotificationDataModel notificationData = NotificationDataModel(
      id: "$id",
      body: 'It`s time to check-in/out',
      title: 'Attendance',
      type: 'check-in',
      image: null,
      url: '',
    );

    String payload = json.encode(notificationData.toJson());

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Future<void> unSubscribeScheduleNotification(data) async {
    await flutterLocalNotificationsPlugin.cancel(data);
  }

  Future<void> unSubscribeScheduleAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showNotificationWithAttachment({
    title,
    body,
    image,
    payload = 'payload',
  }) async {
    final bigPicture = await _downloadAndSaveFile('$image', 'bigPicture');
    final largeIcon = await _downloadAndSaveFile('$image', 'largeIcon');
    final iosPlatformSpecifies = DarwinNotificationDetails(
      attachments: [DarwinNotificationAttachment(bigPicture)],
    );
    final bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicture),
      largeIcon: FilePathAndroidBitmap(largeIcon),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '<p>$body</p>',
      htmlFormatSummaryText: true,
    );
    final androidChannelSpecifies = AndroidNotificationDetails(
      '0',
      "24Hour",
      channelDescription:
          "This channel is responsible for all the local notifications",
      priority: Priority.high,
      importance: Importance.high,
      channelShowBadge: true,
      styleInformation: bigPictureStyleInformation,
    );
    final notificationDetails = NotificationDetails(
      android: androidChannelSpecifies,
      iOS: iosPlatformSpecifies,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$body',
      notificationDetails,
      payload: payload,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    try {
      final response = await http.get(Uri.parse(url));
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } catch (_) {}
    return filePath;
  }

  Future<void> repeatNotification() async {
    const androidChannelSpecifies = AndroidNotificationDetails(
      'CHANNEL_ID 3',
      'CHANNEL_NAME 3',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosChannelSpecifies = DarwinNotificationDetails();
    const platformChannelSpecifies = NotificationDetails(
      android: androidChannelSpecifies,
      iOS: iosChannelSpecifies,
    );
    flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'repeat title',
      'repeat body',
      RepeatInterval.everyMinute,
      platformChannelSpecifies,
      payload: 'payload',
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }
}
