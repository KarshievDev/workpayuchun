import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/widgets/leave_main_content.dart';
import 'leave_type/leave_request_type.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data?.user;
    return BlocProvider(
      create:
          (context) =>
              instance.get<FactoryLeaveBloc>()()
                ..add(LeaveSummaryApi(user!.id!))
                ..add(LeaveRequest(user.id!))
                ..add(LeaveRequestTypeEvent(user.id!)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Leave List'),
              actions: [
                TextButton(
                  onPressed: () {
                    NavUtil.navigateScreen(
                      context,
                      BlocProvider.value(
                        value: context.read<LeaveBloc>(),
                        child: const LeaveRequestType(),
                      ),
                    );
                  },
                  child: Text(
                    'Apply Leave',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide.none),
                      ),
                      child: BlocBuilder<LeaveBloc, LeaveState>(
                        builder: (context, state) {
                          final count =
                              state
                                  .leaveRequestModel
                                  ?.leaveRequestData
                                  ?.leaveRequests
                                  ?.length ??
                              0;

                          final approveCount =
                              state
                                  .leaveRequestModel
                                  ?.leaveRequestData
                                  ?.leaveRequests
                                  ?.where((e) => e.status == 'Active')
                                  .toList()
                                  .length ??
                              0;

                          return TabBar(
                            dividerColor: Colors.transparent,
                            controller: _tabController,
                            indicatorPadding: const EdgeInsets.all(4),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            indicator: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            tabs: [
                              Tab(text: 'Request ($count)'),
                              Tab(text: 'Approve ($approveCount)'),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<LeaveBloc, LeaveState>(
                    builder: (context, state) {
                      final inactiveLeaves =
                          state
                              .leaveRequestModel
                              ?.leaveRequestData
                              ?.leaveRequests
                              ?.where((e) => e.status != 'Active')
                              .toList() ??
                          [];

                      final activeLeaves =
                          state
                              .leaveRequestModel
                              ?.leaveRequestData
                              ?.leaveRequests
                              ?.where((e) => e.status == 'Active')
                              .toList() ??
                          [];

                      if (state.status == NetworkStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          LeaveMainContent(leaves: inactiveLeaves),
                          LeaveMainContent(leaves: activeLeaves),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
