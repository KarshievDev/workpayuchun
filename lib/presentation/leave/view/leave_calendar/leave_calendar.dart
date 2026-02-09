import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/create_leave_request/create_leave_request.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalendar extends StatelessWidget {
  final int? leaveRequestTypeId;

  const LeaveCalendar({super.key, this.leaveRequestTypeId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 50),
            child: AppBar(
              iconTheme: IconThemeData(
                size: DeviceUtil.isTablet ? 40 : 30,
                color: Colors.white,
              ),
              title: Text(
                tr("request_leave"),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: DeviceUtil.isTablet ? 300.h : 300,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  selectionColor: Colors.green,
                  showNavigationArrow: true,
                  toggleDaySelection: false,
                  enablePastDates: false,
                  startRangeSelectionColor: Branding.colors.primaryDark,
                  endRangeSelectionColor: Branding.colors.primaryDark,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (
                    DateRangePickerSelectionChangedArgs args,
                  ) {
                    String? startDate =
                        DateFormat(
                          'yyyy-MM-dd',
                          'en',
                        ).format(args.value.startDate).toString();
                    String? endDate =
                        DateFormat('yyyy-MM-dd', 'en')
                            .format(args.value.endDate ?? args.value.startDate)
                            .toString();
                    context.read<LeaveBloc>().add(
                      SelectedCalendar(startDate, endDate),
                    );
                  },
                ),
              ),
              Spacer(),
              CustomHButton(
                title: "next".tr(),
                padding: 16.0,
                backgroundColor: Branding.colors.primaryDark,
                clickButton: () {
                  if (state.startDate == null) {
                    Fluttertoast.showToast(msg: "Please select Date");
                  } else {
                    final pending =
                        state.leaveRequestModel?.leaveRequestData?.leaveRequests
                            ?.where((e) => e.status?.toLowerCase() == 'pending')
                            .length ??
                        0;
                    final balance =
                        state.leaveSummaryModel?.leaveSummaryData?.leaveBalance;
                    NavUtil.replaceScreen(
                      context,
                      BlocProvider.value(
                        value: context.read<LeaveBloc>(),
                        child: CreateLeaveRequest(
                          leaveTypeId: leaveRequestTypeId,
                          starDate: state.startDate,
                          endDate: state.endDate,
                          leaveType: state.selectedRequestType?.type,
                          pendingLeaves: pending,
                          leaveBalance: balance,
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }
}
