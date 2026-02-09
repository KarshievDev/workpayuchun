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
import 'package:strawberryhrm/res/widgets/common_elevated_button.dart';

class PlutoLeaveTypeViewScreen extends StatelessWidget {
  final LeaveListDatum? data;
  final DailyLeaveState? state;

  const PlutoLeaveTypeViewScreen({super.key, this.data, this.state});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final bloc = context.read<DailyLeaveBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(data?.leaveType ?? tr("daily_leave"),style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white, iconTheme: IconThemeData(color: Branding.colors.textPrimary,),),
      body: BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              Padding(padding:  EdgeInsets.all(12.0.r),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight),borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(flex: 1,child: Text("name".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.staff}"))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("designation".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.designation}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("leave_type".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.leaveType}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("status".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.status}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("leave_data_on".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.date}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("time".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.time}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("reason".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.reason}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("manager_approval".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.approvalDetails?.managerApproval ?? 'N/A'}".tr()))
                              ],),
                              const SizedBox(height: 16,),
                              Row(children: [
                                Expanded(flex: 1,child: Text("hr_approval".tr())),
                                Expanded(flex: 2,child: Text(": ${data?.approvalDetails?.hrApproval ?? 'N/A'}".tr()))
                              ],),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(visible: data?.status != 'Approved' && user?.user?.isHr == true,
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(userId: user!.user!.id!, leaveId: data!.id!, leaveStatus: 'approved', context: context,));
                              },
                              title: Text('approved'.tr(), style: TextStyle(color: Colors.white, fontSize: 12.sp),), bgColor: colorPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(userId: user!.user!.id!, leaveId: data!.id!, leaveStatus: 'rejected', context: context,));
                              },
                              title:  Text('reject', style: TextStyle(color: Colors.white, fontSize: 12.sp),).tr(), bgColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              NetworkStatus.loading == bloc.state.status ? const Center(child: CircularProgressIndicator(),) : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}