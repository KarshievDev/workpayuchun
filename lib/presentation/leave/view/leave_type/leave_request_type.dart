import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_calendar/leave_calendar.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class LeaveRequestType extends StatelessWidget {
  const LeaveRequestType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80.0 : 50),
              child: AppBar(
                title: Text("leave_request_type".tr(),style: TextStyle(fontSize: 16.r),),
                iconTheme:  IconThemeData(
                    size: DeviceUtil.isTablet ? 40 : 30,
                    color: Colors.white
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(0)),
              child: Padding(
                padding:  EdgeInsets.all(8.0.r),
                child: CustomHButton(
                  title: "next".tr(),
                  padding: 16,
                  backgroundColor: Branding.colors.primaryDark,
                  clickButton: () {
                    if (state.selectedRequestType?.id == null) {
                      Fluttertoast.showToast(msg: "Please select Leave Request Type");
                    } else {
                      NavUtil.replaceScreen(context, BlocProvider.value(value: context.read<LeaveBloc>(),
                              child: LeaveCalendar(leaveRequestTypeId: state.selectedRequestType?.id)));
                    }
                  },
                ),
              ),
            ),
            body: state.leaveRequestType?.leaveRequestType?.availableLeave != null
                ? state.leaveRequestType?.leaveRequestType?.availableLeave?.isNotEmpty == true
                    ? ListView.separated(
                        padding:  EdgeInsets.all(12.0.r),
                        shrinkWrap: true,
                        itemCount: state.leaveRequestType?.leaveRequestType?.availableLeave?.length ?? 0,
                        itemBuilder: (context, index) {
                          AvailableLeaveType? availableLeave = state.leaveRequestType?.leaveRequestType?.availableLeave?[index];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.r,
                            child: RadioListTile<AvailableLeaveType>(
                              contentPadding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 12.0.r),
                              value: availableLeave!,
                              title: Row(
                                children: [
                                  Text(
                                    "${availableLeave.type}",
                                    style:  TextStyle(
                                        fontSize: 14.r,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
                                  const Spacer(),
                                  Text(
                                    '${availableLeave.leftDays} ${tr("days_left")}',
                                    style: TextStyle(
                                        fontSize: 14.r,
                                        fontWeight: FontWeight.w500),
                                  ).tr(),
                                ],
                              ),
                              groupValue: state.selectedRequestType,
                              onChanged: (AvailableLeaveType? value) {
                                context.read<LeaveBloc>().add(SelectedRequestType(value!));
                                if (kDebugMode) {
                                  print(value.type);
                                }
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5))
                    : const NoDataFoundWidget()
                : const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GeneralListShimmer(),
                  ));
      },
    );
  }
}