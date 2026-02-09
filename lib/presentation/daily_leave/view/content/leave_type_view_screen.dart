import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_state.dart';
import 'package:strawberryhrm/res/widgets/card_tile_with_content.dart';
import 'package:strawberryhrm/res/widgets/common_elevated_button.dart';

class LeaveTypeViewScreen extends StatelessWidget {
  final LeaveListDatum? data;
  final DailyLeaveState? state;

  const LeaveTypeViewScreen({super.key, this.data, this.state});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final bloc = context.read<DailyLeaveBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.leaveType ?? '').tr(),
      ),
      body: BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              Padding(
                padding:  EdgeInsets.all(12.0.r),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CardTileWithContent(
                              title: 'name',
                              value: data?.staff ?? '',
                            ),
                            CardTileWithContent(
                              title: 'designation',
                              value: data?.designation ?? '',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'leave_type',
                                    value: data?.leaveType ?? '',
                                  ),
                                ),
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'status',
                                    value: data?.status ?? '',
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'leave_data_on',
                                    value: data?.date ?? '',
                                  ),
                                ),
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'time',
                                    value: data?.time ?? '',
                                  ),
                                ),
                              ],
                            ),
                            CardTileWithContent(
                              title: 'reason',
                              value: data?.reason ?? '',
                            ),
                            CardTileWithContent(
                              title: 'manager_approval',
                              value: data?.approvalDetails?.managerApproval ??
                                  'N/A',
                            ),
                            CardTileWithContent(
                              title: 'hr_approval',
                              value: data?.approvalDetails?.hrApproval ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: data?.status != 'Approved' &&
                          user?.user?.isHr == true,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(
                                  userId: user!.user!.id!,
                                  leaveId: data!.id!,
                                  leaveStatus: 'approved',
                                  context: context,
                                ));
                              },
                              title: Text(
                                'approved'.tr(),
                                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                              ),
                              bgColor: colorPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(
                                  userId: user!.user!.id!,
                                  leaveId: data!.id!,
                                  leaveStatus: 'rejected',
                                  context: context,
                                ));
                              },
                              title:  Text(
                                'reject',
                                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                              ).tr(),
                              bgColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              NetworkStatus.loading == bloc.state.status
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}
