import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_type_model.dart';

abstract class DailyLeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DailyLeaveSummary extends DailyLeaveEvent {
  final int userId;

  DailyLeaveSummary(this.userId);

  @override
  List<Object> get props => [userId];
}

class SelectDatePickerDailyLeave extends DailyLeaveEvent {
  final int userId;
  final BuildContext context;

  SelectDatePickerDailyLeave(this.userId, this.context);

  @override
  List<Object> get props => [userId];
}

class SelectApproxTime extends DailyLeaveEvent {
  final String approxTime;

  SelectApproxTime(this.approxTime);

  @override
  List<Object?> get props => [approxTime];
}

class SelectLeaveType extends DailyLeaveEvent {
  final LeaveTypeModel leaveTypeModel;

  SelectLeaveType({required this.leaveTypeModel});

  @override
  List<Object?> get props => [leaveTypeModel];
}

class ApplyLeave extends DailyLeaveEvent {
  final int userId;
  final BuildContext context;

  ApplyLeave({required this.userId, required this.context});

  @override
  List<Object?> get props => [userId, context];
}

class SelectEmployee extends DailyLeaveEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class LeaveAction extends DailyLeaveEvent {
  final int userId;
  final int leaveId;
  final String leaveStatus;
  final BuildContext context;

  LeaveAction(
      {required this.leaveId,
      required this.leaveStatus,
      required this.context,
      required this.userId});

  @override
  List<Object> get props => [leaveId, leaveStatus, userId];
}
