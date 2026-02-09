import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_details_bloc/leave_details_cubit.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_details_bloc/leave_details_state.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/widgets/build_attachment.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/widgets/build_info_card.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/widgets/build_timeline.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/widgets/leave_status_badge.dart';

class LeaveDetails extends StatelessWidget {
  final int requestId;
  final int userId;

  const LeaveDetails({
    super.key,
    required this.requestId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final leaveDetailsCubit = instance.get<LeaveDetailsCubitFactory>();
    return BlocProvider(
      create:
          (context) => leaveDetailsCubit(userId: userId, requestId: requestId),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) {
            final state = context.watch<LeaveDetailsCubit>().state;
            final leaveDetailsData = state.leaveDetailsModel?.leaveDetailsData;
            if (state.isCancelled ||
                leaveDetailsData?.status == LeaveStatusEnum.canceled) {
              return FloatingActionButton.extended(
                onPressed: null,
                backgroundColor: Colors.red,
                label: Text(
                  'leave_request_cancelled'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (leaveDetailsData?.status == LeaveStatusEnum.pending &&
                !state.isCancelled) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        title: Text(
                          'Do you want to cancel leave request?'.tr(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'yes'.tr(),
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<LeaveDetailsCubit>().cancelLeave(
                                onCancelled: () {
                                  context.read<LeaveBloc>().add(
                                    LeaveRequest(userId),
                                  );
                                },
                              );
                            },
                          ),
                          TextButton(
                            child: Text(
                              'no'.tr(),
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Branding.colors.primaryDark,
                label: Text(
                  'cancel_leave_request'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
            iconTheme: IconThemeData(
              size: DeviceUtil.isTablet ? 40 : 30,
              color: Colors.white,
            ),
            title: Text(
              "leave_details".tr(),
              style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.r : 14.r),
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            return BlocBuilder<LeaveDetailsCubit, LeaveDetailsState>(
              builder: (context, state) {
                LeaveDetailsData? leaveDetailsData =
                    state.leaveDetailsModel?.leaveDetailsData;
                if (state.status == NetworkStatus.loading &&
                    state.isCancelled == false) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: GeneralListShimmer(),
                  );
                } else if (state.status == NetworkStatus.success ||
                    state.isCancelled == true) {
                  return Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: LeaveStatusBadge(
                              status: leaveDetailsData?.status,
                              colorCode: leaveDetailsData?.colorCode,
                              isCancelled: state.isCancelled,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (leaveDetailsData != null)
                            BuildTimeline(data: leaveDetailsData),
                          const SizedBox(height: 12),
                          if (leaveDetailsData != null)
                            BuildInfoCard(data: leaveDetailsData),
                          const SizedBox(height: 12),
                          if (leaveDetailsData != null)
                            BuildAttachment(data: leaveDetailsData),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
