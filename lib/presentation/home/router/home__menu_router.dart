import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notification/notification.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/view/appointment_screen.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/pluto_attendance_report_page.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/daily_leave_page.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_daily_leave_page.dart';
import 'package:strawberryhrm/presentation/home/view/content/home_content_shimmer.dart';
import 'package:strawberryhrm/presentation/home/view/home_mars/content_mars/home_mars_content.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/home_neptune_content.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/home_pluto_content.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_page.dart';
import 'package:strawberryhrm/presentation/meeting/view/meeting_page.dart';
import 'package:strawberryhrm/presentation/menu/view/menu_screen.dart';
import 'package:strawberryhrm/presentation/menu/view/pluto_menu_screen.dart';
import 'package:strawberryhrm/presentation/select_employee/content/employee_list_shimmer.dart';
import 'package:strawberryhrm/presentation/support/view/support_page.dart';
import 'package:strawberryhrm/presentation/visit/view/visit_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

Widget chooseTheme() {
  final name = globalState.get(dashboardStyleId);
  switch (name) {
    case 'earth':
      return const HomePlutoContent();
    case 'neptune':
      return const HomeNeptuneContent();
    case 'mars':
      return const HomeMarsContent();
    case 'pluto':
      return const HomePlutoContent();
    default:
      return const HomeContentShimmer();
  }
}

Widget chooseMenu() {
  final name = globalState.get(dashboardStyleId);
  switch (name) {
    case 'pluto':
      return const PlutoMenuScreen();
    default:
      return const MenuScreen();
  }
}

Widget chooseNotification() {
  final name = globalState.get(dashboardStyleId);
  final notificationScreen = instance<NotificationsScreenFactory>();
  switch (name) {
    case 'pluto':
    case 'earth':
    case 'neptune':
    case 'mars':
      return notificationScreen();
    default:
      return const EmployeeListShimmer();
  }
}

Widget chooseDailyLeave() {
  final name = globalState.get(dashboardStyleId);
  switch (name) {
    case 'pluto':
      return const PlutoDailyLeavePage();
    case 'earth':
    case 'neptune':
    case 'mars':
      return const DailyLeavePage();
    default:
      return const EmployeeListShimmer();
  }
}

void routeSlug(slugName, context) {
  switch (slugName) {
    case 'support':
      NavUtil.navigateScreen(context, const SupportPage());
    case 'support_ticket':
      NavUtil.navigateScreen(context, const SupportPage());
    case 'visit':
      NavUtil.navigateScreen(context, const VisitPage());
    case 'appointment':
      NavUtil.navigateScreen(context, const AppointmentScreen());
    case 'meeting':
      NavUtil.navigateScreen(context, const MeetingPage());
    default:
      if (kDebugMode) {
        print(slugName);
      }
      return debugPrint('default');
  }
}

void currentMonthRouteSlug(slugName, context, settings) {
  switch (slugName) {
    case 'late_in':
      NavUtil.navigateScreen(context, PlutoAttendanceReportPage(settings: settings!));
    case 'absent':
      NavUtil.navigateScreen(context, PlutoAttendanceReportPage(settings: settings!));
    case 'leave':
      NavUtil.navigateScreen(context, const LeavePage());

    case 'visits':
      NavUtil.navigateScreen(context, const VisitPage());
    default:
      if (kDebugMode) {
        print(slugName);
      }
      return debugPrint('default');
  }
}
