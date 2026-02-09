import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/approval/approval.dart';
import 'package:strawberryhrm/presentation/approval/view/content/leave_type_content.dart';
import 'package:strawberryhrm/res/widgets/card_tile_with_content.dart';
import 'package:strawberryhrm/presentation/approval/view/content/substitute_content.dart';
import 'package:strawberryhrm/res/widgets/common_elevated_button.dart';

class PlutoApprovalDetailsScreen extends StatelessWidget {
  const PlutoApprovalDetailsScreen({super.key, required this.approvalUserId, required this.bloc, required this.approvalId});

  final String approvalUserId;
  final String approvalId;
  final ApprovalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApprovalBloc, ApprovalState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(tr("approval_details"),style: const TextStyle(color: Colors.black),),
          backgroundColor: Colors.white, iconTheme: IconThemeData(color: Branding.colors.textSecondary,),),
        body: Stack(
          children: [
            FutureBuilder(
              future: bloc.onApprovalDetails(approvalId: approvalId, approvalUserId: approvalUserId),
              builder: (_, snapshot) {
                final data = snapshot.data?.approvalDetailsData;
                final isStatus = bloc.isApproved(data?.status);
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CardTileWithContent(
                              title: 'employee_name', value: data?.name ?? ''),
                          CardTileWithContent(
                              title: 'department',
                              value: data?.department ?? ''),
                          CardTileWithContent(
                              title: 'designation',
                              value: data?.designation ?? ''),
                          CardTileWithContent(
                              title: 'request_leave_on',
                              value: data?.requestedOn ?? ''),
                          LeaveTypeContent(data: data),
                          SubstituteContent(data: data),
                          CardTileWithContent(
                              title: 'employee_note', value: data?.note ?? ''),
                          CardTileWithContent(
                              title: 'approves',
                              value: data?.apporover ?? 'N/A'),
                          SizedBox(height: 6.h),
                          Visibility(
                            visible: isStatus,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomElevatedButton(
                                    onTap: () {
                                      /// approved == 1
                                      if (bloc.state.status == NetworkStatus.success) {
                                        bloc.add(ApproveOrRejectAction(approvalId: approvalId, type: 1, context: context));
                                      } else {
                                        return;
                                      }
                                    },
                                    title:  Text('approved', style: TextStyle(color: Colors.white, fontSize: 14.r),).tr(),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomElevatedButton(
                                    onTap: () {
                                      /// reject == 6
                                      if (bloc.state.status == NetworkStatus.success) {
                                        bloc.add(ApproveOrRejectAction(approvalId: approvalId, type: 6, context: context));
                                      } else {
                                        return;
                                      }
                                    },
                                    title: Text('reject', style: TextStyle(color: Colors.white, fontSize: 14.r),).tr(),
                                    bgColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: bloc.state.status == NetworkStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                      ))
                    : const SizedBox.shrink())
          ],
        ),
      );
    });
  }
}
