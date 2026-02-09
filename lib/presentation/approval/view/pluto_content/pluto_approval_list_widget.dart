import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/approval/approval.dart';
import 'package:strawberryhrm/presentation/approval/view/pluto_content/pltuo_approval_details_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class PlutoApprovalListWidget extends StatelessWidget {
  const PlutoApprovalListWidget({super.key, required this.approvalLeaveRequestData});

  final ApprovalLeaveRequest? approvalLeaveRequestData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<ApprovalBloc>(), child: PlutoApprovalDetailsScreen(approvalUserId: '${approvalLeaveRequestData?.userId}', bloc: context.read<ApprovalBloc>(), approvalId: "${approvalLeaveRequestData!.id}")));
      },
      title: Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(approvalLeaveRequestData?.message ?? '', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.r),),
            ),
            Chip(
                backgroundColor: Color(int.tryParse(approvalLeaveRequestData?.colorCode ?? '') ?? 0),
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2).r,
                shape: const StadiumBorder(),
                label: Text(approvalLeaveRequestData?.status ?? '', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontSize: 12.r),).tr()),
            Chip(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2).r,
                shape: const StadiumBorder(),
                label: Text(approvalLeaveRequestData?.type ?? '', style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12.r)).tr()),

          ]),
      subtitle: Row(
        children: [
          Chip(
              label: Text('Apply Date : ${approvalLeaveRequestData?.applyDate}'.tr(), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.r)).tr())
        ],
      ),
    );
  }
}
