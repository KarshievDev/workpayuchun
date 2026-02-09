import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_details/leave_details.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'leave_card.dart';

class LeaveMainContent extends StatelessWidget {
  final List<LeaveRequestValue> leaves;

  const LeaveMainContent({super.key, required this.leaves});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data?.user;
    final canApprove = user?.isHr == true || user?.isAdmin == true;

    return leaves.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: leaves.length,
          itemBuilder: (context, index) {
            final item = leaves[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: LeaveCard(
                avatarUrl: user?.avatar ?? '',
                email: user?.email ?? '',
                name: user?.name ?? '',
                role: item.status ?? '',
                leaveType: item.type ?? '',
                dateFrom: item.applyDate ?? '',
                dateTo: item.applyDate ?? '',
                leaveDay: '${item.days ?? ''}',
                showActions: canApprove,
                onTap: () {
                  NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                      value: context.read<LeaveBloc>(),
                      child: LeaveDetails(
                        requestId: item.id ?? 0,
                        userId: user!.id!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
        : NoDataFoundWidget();
  }
}
