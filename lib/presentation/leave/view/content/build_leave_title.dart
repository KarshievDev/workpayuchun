import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/leave_details.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class BuildLeaveTitle extends StatelessWidget {
  final LeaveRequestValue? leaveRequestValue;
  final int userId;

  const BuildLeaveTitle(
      {super.key, required this.leaveRequestValue, required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.navigateScreen(
            context,
            BlocProvider.value(
                value: context.read<LeaveBloc>(),
                child: LeaveDetails(
                    requestId: leaveRequestValue!.id!, userId: userId)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtil.isTablet ? 10.r : 12,
                        vertical: 2),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: colorPrimary,
                    ),
                    child: Text(
                      leaveRequestValue?.applyDate
                              .toString()
                              .split(" ")[0]
                              .toUpperCase() ??
                          "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: DeviceUtil.isTablet ? 12.r : 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      leaveRequestValue?.applyDate.toString().split(" ")[1] ??
                          "",
                      style:
                          TextStyle(fontSize: DeviceUtil.isTablet ? 14.r : 14),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "${leaveRequestValue?.type} ",
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 12.r : 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                      Text(
                        '${leaveRequestValue?.days} ${tr('days')}',
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 12.r : 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: DeviceUtil.isTablet ? 120 : 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(
                            int.parse(leaveRequestValue?.colorCode ?? "")),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      color:
                          Color(int.parse(leaveRequestValue?.colorCode ?? "")),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DottedBorder(
                      color: Colors.white,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      strokeWidth: 1,
                      child: Center(
                        child: Text(
                          '${leaveRequestValue?.status}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: DeviceUtil.isTablet ? 10.r : 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: colorPrimary.withValues(alpha: 0.1)),
              child: Icon(
                Icons.arrow_forward_ios,
                size: DeviceUtil.isTablet ? 18.r : 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
