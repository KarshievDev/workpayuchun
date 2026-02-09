import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_state.dart';
import 'package:strawberryhrm/presentation/break/break_route.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/widgets/action_button_card.dart';
import 'package:user_repository/user_repository.dart';
import 'package:core/core.dart';

class PlutoBreakCard extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const PlutoBreakCard({
    super.key,
    required this.settings,
    required this.user,
    required this.dashboardModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfflineCubit, OfflineAttendanceState>(
      builder: (context, offlineState) {
        return ActionButtonCard(
          icon: Lottie.asset('assets/images/tea_time.json', fit: BoxFit.fill),
          title:
              globalState.get(isBreak) == true
                  ? "you're_in_break".tr()
                  : "take_coffee".tr(),
          subtitle:
              globalState.get(isBreak) == true
                  ? dashboardModel?.data?.config?.breakStatus?.breakTime ?? ''
                  : 'break'.tr(),
          onTap: () {
            BreakRoute.breakOrQrCompanyRoute(
              context: context,
              inBreak: globalState.get(isBreak) == true,
            );
          },
          isCheckedIn: globalState.get(isBreak) == true,
        );
      },
    );
  }
}
