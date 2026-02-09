import 'dart:async';
import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/approval/approval.dart';
import 'package:strawberryhrm/presentation/approval/view/pluto_approval_screen.dart';
import 'package:strawberryhrm/presentation/attendance_method/view/attendane_method_screen.dart';
import 'package:strawberryhrm/presentation/break/break_route.dart';
import 'package:strawberryhrm/presentation/conference/conference.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/daily_leave_page.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_page.dart';
import 'package:strawberryhrm/presentation/document/view/documents_request_page.dart';
import 'package:strawberryhrm/presentation/expense/view/expense_page.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/view/appointment_screen.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_page.dart';
import 'package:strawberryhrm/presentation/meeting/meeting.dart';
import 'package:strawberryhrm/presentation/notice_list/view/notice_list_screen.dart';
import 'package:strawberryhrm/presentation/payroll/view/view.dart';
import 'package:strawberryhrm/presentation/phonebook/view/phonebook_page.dart';
import 'package:strawberryhrm/presentation/phonebook/view/pluto_phonebook_page.dart';
import 'package:strawberryhrm/presentation/report/report_page.dart';
import 'package:strawberryhrm/presentation/system_report/view/system_report_page.dart';
import 'package:strawberryhrm/presentation/task/task.dart';
import 'package:strawberryhrm/presentation/support/view/support_page.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/travel_page.dart';
import 'package:strawberryhrm/presentation/visit/view/visit_page.dart';
import 'package:strawberryhrm/presentation/writeup/view/complain_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:user_repository/user_repository.dart';


part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final LoginData _loginData;
  final Color _primaryColor;
  final GetAppNameUseCase _getAppName;
  final GetAppVersionUseCase _getAppVersion;

  MenuBloc(
      {required LoginData loginData,
      required Color color,
      required GetAppNameUseCase getAppName,
      required GetAppVersionUseCase getAppVersion})
      : _loginData = loginData,
        _getAppName = getAppName,
        _getAppVersion = getAppVersion,
        _primaryColor = color,
        super(const MenuState(
          status: NetworkStatus.initial,
        )) {
    on<RouteSlug>(onRouteSlug);
    on<OnAppServiceEvent>(_onAppService);
  }

  void onRouteSlug(
    RouteSlug event,
    Emitter<MenuState> emit,
  ) {
    switch (event.slugName) {
      case 'support':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      case 'attendance':
        Navigator.push(event.context, AttendanceMethodScreen.route(homeBloc: event.context.read<HomeBloc>()));
        break;
      case 'notice':
        NavUtil.navigateScreen(event.context, const NoticeListScreen());
        break;
      case 'daily-work':
        NavUtil.navigateScreen(event.context, const DailyReportPage());
        break;
      case 'travel':
        NavUtil.navigateScreen(event.context, const TravelPage());
        break;
      case 'expense':
        NavUtil.navigateScreen(event.context, const ExpensePage());
        break;
      case 'leave':
        NavUtil.navigateScreen(event.context, const LeavePage());
        break;
      case 'approval':
        final name = globalState.get(dashboardStyleId);
        switch (name) {
          case 'pluto':
            NavUtil.navigateScreen(event.context, const PlutoApprovalScreen());
          case 'earth':
          case 'neptune':
          case 'mars':
            NavUtil.navigateScreen(event.context, const ApprovalScreen());
          default:
            NavUtil.navigateScreen(event.context, const ApprovalScreen());

        }
        break;
      case 'chat':
        NavUtil.navigateScreen(
            event.context,
            ChatRoom(
              uid: '${globalState.get(companyId)}${_loginData.user?.id ?? 0}',
              primaryColor: _primaryColor,
              cid: '${globalState.get(companyId)}',
            ));
        break;
      case 'phonebook':
        final name = globalState.get(dashboardStyleId);
        switch (name) {
          case 'pluto':
            NavUtil.navigateScreen(event.context, PlutoPhoneBookPage(settings: event.context.read<HomeBloc>().state.settings,));
          case 'earth':
          case 'neptune':
          case 'mars':
            NavUtil.navigateScreen(event.context, PhoneBookPage(settings: event.context.read<HomeBloc>().state.settings));
          default:
            NavUtil.navigateScreen(event.context, PhoneBookPage(settings: event.context.read<HomeBloc>().state.settings));
        }
      case 'conference':
        NavUtil.navigateScreen(event.context, const ConferencePage());
        break;
      case 'visit':
        NavUtil.navigateScreen(event.context, const VisitPage());
        break;
      case 'meeting':
        NavUtil.navigateScreen(event.context, const MeetingPage());
        break;
      case 'appointments':
        NavUtil.navigateScreen(event.context, const AppointmentScreen());
        break;
      case 'break':
        BreakRoute.breakOrQrCompanyRoute(
            context: event.context,
            inBreak: globalState.get(isBreak) == true);
        break;
      case 'feedback':
      case 'report':
        NavUtil.navigateScreen(event.context, const ReportPage());
        break;
      case 'daily_leave':
        NavUtil.navigateScreen(event.context, const DailyLeavePage());
        break;
      case 'payroll':
        NavUtil.navigateScreen(event.context, const PayrollScreen());
        break;
      case 'task':
        NavUtil.navigateScreen(event.context, const TaskScreen());
        break;
      case 'system-report':
        NavUtil.navigateScreen(event.context, const SystemReportPage());
        break;
      case 'complain':
        NavUtil.navigateScreen(event.context, const ComplainPage());
        break;
      case 'document':
        NavUtil.navigateScreen(event.context, const DocumentsRequestPage());
        break;
      default:
        return debugPrint('default');
    }
  }

  FutureOr<void> _onAppService(OnAppServiceEvent event, Emitter<MenuState> emit) async {
    final appVersion = await _getAppVersion();
    final appName = await _getAppName();
    emit(state.copy(appVersion: appVersion, appName: appName));
  }
}
