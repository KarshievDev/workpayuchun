import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_state.dart';
import 'package:strawberryhrm/presentation/attendance_method/view/attendane_method_screen.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/widgets/action_button_card.dart';
import 'package:user_repository/user_repository.dart';

class PlutoCheckInOutCard extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const PlutoCheckInOutCard({
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
          icon: Lottie.asset(
            'assets/images/check-in-out.json',
            fit: BoxFit.fill,
          ),
          title:
              offlineState.isCheckedIn == false
                  ? 'check_in'.tr()
                  : 'check_out'.tr(),
          subtitle:
              offlineState.isCheckedIn == false
                  ? 'start_time'.tr()
                  : 'done_for_today'.tr(),
          onTap: () {
            context.read<HomeBloc>().add(
              OnLocationRefresh(
                user: context.read<AuthenticationBloc>().state.data?.user,
              ),
            );
            Navigator.push(
              context,
              AttendanceMethodScreen.route(homeBloc: context.read<HomeBloc>()),
            );
          },
          isCheckedIn: offlineState.isCheckedIn,
        );
      },
    );
  }
}
