import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

class Settings extends Equatable {
  const Settings({this.result, this.message, this.data});

  final bool? result;
  final String? message;
  final Setting? data;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      Settings(result: json["result"], message: json["message"], data: Setting.fromJson(json["data"]));

  @override
  List<Object?> get props => [result, message, data];
}

class Setting extends Equatable {
  const Setting({
    this.isIpEnabled,
    this.timeWish,
    this.timeZone,
    this.currencyCode,
    this.dutySchedule,
    this.breakStatus,
    this.isHr,
    this.isAdmin,
    this.isFaceRegistered,
    this.multiCheckIn,
    this.locationService,
    this.liveTracking,
    this.barikoiAPI,
    this.attendanceMethod,
    this.departments = const [],
    this.designations = const [],
    this.methods = const [],
    this.employeeTypes = const [],
    this.appTheme,
    this.notificationChannels = const [],
    this.shifts = const [],
  });

  final bool? isIpEnabled;
  final bool? isHr;
  final bool? isAdmin;
  final bool? isFaceRegistered;
  final bool? multiCheckIn;
  final bool? locationService;
  final TimeWish? timeWish;
  final BarikoiAPI? barikoiAPI;
  final String? timeZone;
  final String? currencyCode;
  final String? attendanceMethod;
  final DutySchedule? dutySchedule;
  final TodayBreakItem? breakStatus;
  final LiveTracking? liveTracking;
  final List<Department> departments;
  final List<Department> designations;
  final List<AttendanceMethod> methods;
  final List<String> employeeTypes;
  final String? appTheme;
  final List<String>? notificationChannels;
  final List<MultiShift> shifts;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    isHr: json["is_hr"],
    isAdmin: json["is_admin"],
    isFaceRegistered: json["is_face_registered"],
    locationService: json["location_service"],
    isIpEnabled: json["is_ip_enabled"],
    timeWish: TimeWish.fromJson(json["time_wish"]),
    barikoiAPI: null,
    timeZone: json["time_zone"],
    multiCheckIn: json["multi_checkin"],
    currencyCode: json["currency_code"],
    attendanceMethod: json["attendance_method"],
    dutySchedule: DutySchedule.fromJson(json['duty_schedule']),
    breakStatus: TodayBreakItem.fromJson(json["break_status"]),
    liveTracking: LiveTracking.fromJson(json["live_tracking"]),
    departments:
        json["departments"] != null
            ? List<Department>.from((json["departments"] as List).map((e) => Department.fromJson(e)))
            : [],
    designations:
        json["designations"] != null
            ? List<Department>.from((json["designations"] as List).map((e) => Department.fromJson(e)))
            : [],
    methods:
        json["attendance_methods"] != null
            ? List<AttendanceMethod>.from((json["attendance_methods"] as List).map((e) => AttendanceMethod.fromJson(e)))
            : [],
    employeeTypes: List<String>.from(json["employee_types"]),
    appTheme: json['app_theme'],
    notificationChannels:
        json["notification_channels"] == null ? [] : List<String>.from(json["notification_channels"]!.map((x) => x)),
    shifts:
        json["multi_shift"] == null
            ? []
            : List<MultiShift>.from(json["multi_shift"]!.map((x) => MultiShift.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'is_hr': isHr,
    'is_admin': isAdmin,
    'is_face_registered': isFaceRegistered,
    'location_service': locationService,
    'is_ip_enabled': isIpEnabled,
    'time_wish': timeWish?.toJson(),
    'barikoi_api': barikoiAPI?.toJson(),
    'time_zone': timeZone,
    'multi_checkin': multiCheckIn,
    'currency_code': currencyCode,
    'attendance_method': attendanceMethod,
    'duty_schedule': dutySchedule?.toJson(),
    'break_status': breakStatus?.toJson(),
    'live_tracking': liveTracking?.toJson(),
    'departments': departments.map((e) => e.toJson()).toList(),
    'designations': designations.map((e) => e.toJson()).toList(),
    'attendance_methods': methods.map((e) => e.toJson()).toList(),
    'employee_types': employeeTypes,
    'app_theme': appTheme,
    "notification_channels":
        notificationChannels == null ? [] : List<dynamic>.from(notificationChannels!.map((x) => x)),
    "multi_shift": List<dynamic>.from(shifts.map((x) => x)),
  };

  @override
  List<Object?> get props => [
    isIpEnabled,
    currencyCode,
    attendanceMethod,
    isAdmin,
    isFaceRegistered,
    appTheme,
    isHr,
    methods,
    attendanceMethod,
    departments,
    breakStatus,
    dutySchedule,
    shifts,
  ];
}

class DutySchedule {
  DutySchedule({this.startTime, this.endTime});

  Time? startTime;
  Time? endTime;

  factory DutySchedule.fromJson(Map<String, dynamic> json) =>
      DutySchedule(startTime: Time.fromJson(json["start_time"]), endTime: Time.fromJson(json["end_time"]));

  Map<String, dynamic> toJson() => {"start_time": startTime!.toJson(), "end_time": endTime!.toJson()};
}

class Time {
  Time({this.hour, this.min, this.sec});

  int? hour;
  int? min;
  int? sec;

  factory Time.fromJson(Map<String, dynamic> json) => Time(hour: json["hour"], min: json["min"], sec: json["sec"]);

  Map<String, dynamic> toJson() => {"hour": hour, "min": min, "sec": sec};
}

class MultiShift extends Equatable {
  const MultiShift({this.shiftId, this.shiftName});

  final int? shiftId;
  final String? shiftName;

  factory MultiShift.fromJson(Map<String, dynamic> json) =>
      MultiShift(shiftId: json["shift_id"], shiftName: json["name"]);

  Map<String, dynamic> toJson() => {"shift_id": shiftId, "name": shiftName};

  @override
  List<Object?> get props => [shiftId, shiftName];
}

class LiveTracking {
  LiveTracking({this.appSyncTime, this.liveDataStoreTime});

  String? appSyncTime;
  String? liveDataStoreTime;

  factory LiveTracking.fromJson(Map<String, dynamic> json) =>
      LiveTracking(appSyncTime: json["app_sync_time"], liveDataStoreTime: json["live_data_store_time"]);

  Map<String, dynamic> toJson() => {"app_sync_time": appSyncTime, "live_data_store_time": liveDataStoreTime};
}

class BreakStatus {
  BreakStatus({this.date, this.breakTime, this.backTime, this.status, this.diffTime});

  DateTime? date;
  String? breakTime;
  String? backTime;
  String? status;
  String? diffTime;

  factory BreakStatus.fromJson(Map<String, dynamic> json) => BreakStatus(
    date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
    breakTime: json["break_time"],
    backTime: json["back_time"],
    status: json["status"],
    diffTime: json["diff_time"],
  );

  Map<String, dynamic> toJson() => {
    "date":
        "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "break_time": breakTime,
    "back_time": backTime,
    "status": status,
    "diff_time": diffTime,
  };
}

class TimeWish {
  TimeWish({this.wish, this.subTitle, this.image});

  String? wish;
  String? subTitle;
  String? image;

  factory TimeWish.fromJson(Map<String, dynamic> json) =>
      TimeWish(wish: json["wish"], subTitle: json["sub_title"], image: json["image"]);

  Map<String, dynamic> toJson() => {"wish": wish, "sub_title": subTitle, "image": image};
}

class BarikoiAPI {
  BarikoiAPI({this.key, this.secret, this.endPoint, this.statusId});

  String? key;
  String? secret;
  String? endPoint;
  int? statusId;

  factory BarikoiAPI.fromJson(Map<String, dynamic> json) => BarikoiAPI(
    key: json["key"],
    secret: json["secret"],
    endPoint: json["endpoint"],
    statusId: int.parse(json["status_id"] != null ? json["status_id"].toString() : '0'),
  );

  Map<String, dynamic> toJson() => {"key": key, "secret": secret, "endpoint": endPoint, "status_id": statusId};
}

class Department extends Equatable {
  final int? id;
  final String? title;

  const Department({this.id, this.title});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title};

  @override
  List<Object?> get props => [id, title];
}

class AttendanceMethod extends Equatable {
  final String? slug;
  final String? title;
  final String? subTitle;
  final String? image;

  const AttendanceMethod({this.slug, this.title, this.subTitle, this.image});

  factory AttendanceMethod.fromJson(Map<String, dynamic> json) {
    return AttendanceMethod(
      slug: json['slug'],
      title: json['title'],
      subTitle: json['short_description'],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {'slug': slug, 'title': title};

  @override
  List<Object?> get props => [slug, title, subTitle, image];
}
