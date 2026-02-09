import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_type_model.dart';

class DailyLeaveState extends Equatable {
  final NetworkStatus? status;
  final DailyLeaveSummaryModel? dailyLeaveSummaryModel;
  final String? currentMonth;
  final String? approxTime;
  final LeaveTypeModel? leaveTypeModel;
  final PhoneBookUser? selectEmployee;
  final LeaveTypeListModel? leaveTypeListData;

  const DailyLeaveState(
      {this.status,
      this.dailyLeaveSummaryModel,
      this.currentMonth,
      this.approxTime,
      this.leaveTypeModel,
      this.leaveTypeListData,
      this.selectEmployee});

  DailyLeaveState copyWith(
      {NetworkStatus? status,
      DailyLeaveSummaryModel? dailyLeaveSummaryModel,
      String? currentMonth,
      String? approxTime,
      LeaveTypeModel? leaveTypeModel,
      LeaveTypeListModel? leaveTypeListData,
      PhoneBookUser? selectEmployee}) {
    return DailyLeaveState(
        status: status ?? this.status,
        dailyLeaveSummaryModel:
            dailyLeaveSummaryModel ?? this.dailyLeaveSummaryModel,
        currentMonth: currentMonth ?? this.currentMonth,
        approxTime: approxTime ?? this.approxTime,
        leaveTypeModel: leaveTypeModel ?? this.leaveTypeModel,
        leaveTypeListData: leaveTypeListData ?? this.leaveTypeListData,
        selectEmployee: selectEmployee ?? this.selectEmployee);
  }

  @override
  List<Object?> get props => [
        status,
        dailyLeaveSummaryModel,
        currentMonth,
        leaveTypeModel,
        approxTime,
        selectEmployee,
        leaveTypeListData
      ];
}
