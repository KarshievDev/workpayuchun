part of 'leave_bloc.dart';

class LeaveState extends Equatable {
  final NetworkStatus? status;
  final LeaveSummaryModel? leaveSummaryModel;
  final LeaveRequestModel? leaveRequestModel;
  final LeaveRequestTypeModel? leaveRequestType;
  final AvailableLeaveType? selectedRequestType;
  final String? startDate;
  final String? endDate;
  final String? currentMonth;
  final bool isCancelled;
  final PhoneBookUser? selectedEmployee;
  final LeaveDetailsModel? leaveDetailsModel;

  const LeaveState(
      {this.status,
      this.leaveSummaryModel,
      this.leaveRequestModel,
      this.leaveRequestType,
      this.selectedRequestType,
      this.startDate,
      this.selectedEmployee,
      this.endDate,
      this.isCancelled = false,
      this.currentMonth,
      this.leaveDetailsModel});

  LeaveState copyWith(
      {LeaveSummaryModel? leaveSummaryModel,
      NetworkStatus? status,
      bool? isCancelled,
      LeaveRequestModel? leaveRequestModel,
      LeaveRequestTypeModel? leaveRequestType,
      AvailableLeaveType? selectedRequestType,
      String? startDate,
      String? currentMonth,
      final PhoneBookUser? selectedEmployee,
      String? endDate,
      LeaveDetailsModel? leaveDetailsModel}) {
    return LeaveState(
        status: status ?? this.status,
        isCancelled: isCancelled ?? this.isCancelled,
        leaveSummaryModel: leaveSummaryModel ?? this.leaveSummaryModel,
        leaveRequestModel: leaveRequestModel ?? this.leaveRequestModel,
        leaveRequestType: leaveRequestType ?? this.leaveRequestType,
        selectedRequestType: selectedRequestType ?? this.selectedRequestType,
        startDate: startDate ?? this.startDate,
        selectedEmployee: selectedEmployee ?? this.selectedEmployee,
        endDate: endDate ?? this.endDate,
        currentMonth: currentMonth ?? this.currentMonth,
        leaveDetailsModel: leaveDetailsModel ?? this.leaveDetailsModel);
  }

  @override
  List<Object?> get props => [
        status,
        leaveSummaryModel,
        leaveRequestModel,
        leaveRequestType,
        selectedRequestType,
        startDate,
        endDate,
        selectedEmployee,
        currentMonth,
        isCancelled,
        leaveDetailsModel
      ];
}
