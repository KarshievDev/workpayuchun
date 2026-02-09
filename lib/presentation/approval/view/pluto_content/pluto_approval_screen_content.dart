import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/approval/approval.dart';
import 'package:strawberryhrm/presentation/approval/view/pluto_content/pluto_approval_list_widget.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class PlutoApprovalScreenContent extends StatelessWidget {
  const PlutoApprovalScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApprovalBloc, ApprovalState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text(tr("approval"),style: const TextStyle(color: Colors.black),), backgroundColor: Colors.white, iconTheme: IconThemeData(color: Branding.colors.textSecondary,),),
          body: state.status == NetworkStatus.loading
              ? ListView.builder(itemBuilder: (BuildContext context, int index) {
                    return const Padding(padding: EdgeInsets.all(12.0), child: RectangularCardShimmer(height: 120.0, width: double.infinity,),);})
              : state.approval?.approvalData?.leaveRequests?.isNotEmpty == true
                  ? ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      itemCount: state.approval?.approvalData?.leaveRequests?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = state.approval?.approvalData?.leaveRequests?[index];
                        return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5),)),
                          child: PlutoApprovalListWidget(approvalLeaveRequestData: data),
                        );
                      },
                    )
                  : const NoDataFoundWidget(),
        );
      },
    );
  }
}
