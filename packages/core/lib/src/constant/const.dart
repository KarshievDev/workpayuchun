import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color mainColor = const Color(0xFF1875E2);
Color buttonColor = const Color(0xFF1875E2);
const Color colorPrimary = Color(0xFF1875E2);
const Color colorCardBackground = Color(0xffF3F9FE);
const Color backgroundColor = Color(0xFFF6F6F6);
const Color primaryBorderColor = Color(0xFFF3E9E7);
const Color colorPrimaryGradient = Color(0xff00a7ab);
const Color colorDeepRed = Color(0xFFBE5258);
const Color appBarColor = Colors.white;
const Color appColor = Color(0xFF1F0732);
const Color gradiantColorOne = Color(0xFF00a8e6);
const Color gradiantColorTwo = Color(0xDA0DC21E);
const Color colorGray = Color(0x65555555);
const Color lightColorGray = Color(0xFFF5F5F5);
const Color deepColorGreen = Color(0xFF07936C);
const Color bgColor = Color(0xFFF5F5F5);

final initialTheme = ThemeData(
  dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  primaryColor: colorPrimary,
  appBarTheme: const AppBarTheme(
    toolbarHeight: 50.0,
    backgroundColor: colorPrimary,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: colorPrimary),
    iconTheme: IconThemeData(color: Colors.white, size: 18.0),
  ),
);

List<String> supportTicketsButton = ["open", 'close', 'all'];

final bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

const String companyName = 'company_name';
const String authToken = 'auth_token';
const String companyId = 'company_id';
const String companyUrl = 'company_url';
const String companySubDomain = 'company_sub_domain';
const String attendanceId = 'attendance_id';
const String dashboardStyleId = 'dashboard_style_Id';
const String inTime = 'in_time';
const String outTime = 'out_time';
const String breakTime = 'break_time';
const String backTime = 'back_time';
const String hour = 'hour';
const String min = 'min';
const String sec = 'sec';
const String isBreak = 'break_status';
const String userFaceData = 'face_data';
const String user = 'user';
const String stayTime = 'stay_time';
const String keyAuthToken = "key_Auth_token";
const String keyIsAdmin = "key_Is_Admin";
const String keyIsHr = "key_Is_Hr";
const String keyUserId = "user_id";
const String keyProfileImage = "user_profile_image";
const String keyName = "user_name";
const String keyCheckInID = "check_in_id";
const String keyAndroidDeviceToken = "android_device_token";
const String keyIosDeviceToken = "ios_device_token";
const String keySelectLanguage = "key_select_language";
const String keyRemoteModeType = "key_remote_mode_type";
const String keyMenuList = "key_menu_list";
const String isLocation = "isLocation";
const String isHR= "isHR";
const String isAdmin = "isAdmin";
const String isTokenVerified = "isTokenVerified";
const String isDisclosure = "isDisclosure";
const String shiftId = "shiftId";
const String notificationChannels = "notification_channels";
const List languages = [
  {
    'name': 'English',
    'image':
        'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcQVhwOar0FyOb_mmItcTAQFv1O4k8S_ZUEAI45O7dYC2rXRUWD-nWJwOQWJS2va8krELcDtY0JEVdQabkDkEdo',
  },
  {
    'name': 'Bangla',
    'image': 'https://cdn.britannica.com/67/6267-004-10A21DF0/Flag-Bangladesh.jpg',
  },
  {
    'name': 'Arabic',
    'image': 'https://cdn.britannica.com/79/5779-004-DC479508/Flag-Saudi-Arabia.jpg',
  }
];

const rootUrl = 'https://workpay.uz';
