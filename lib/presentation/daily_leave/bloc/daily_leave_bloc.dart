import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_state.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_list_model.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_type_model.dart';

class DailyLeaveBloc extends Bloc<DailyLeaveEvent, DailyLeaveState> {
  final MetaClubApiClient _metaClubApiClient;
  final reasonTextController = TextEditingController();

  DailyLeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const DailyLeaveState(status: NetworkStatus.initial)) {
    on<DailyLeaveSummary>(_dailyLeaveSummary);
    on<SelectDatePickerDailyLeave>(_onSelectDatePicker);
    on<SelectApproxTime>(_onSelectTimePicker);
    on<SelectLeaveType>(_onSelectLeaveType);
    on<ApplyLeave>(_onApplyLeave);
    on<SelectEmployee>(_selectEmployee);
    on<LeaveAction>(_onLeaveAction);
  }

  ///leave type defined
  List<LeaveTypeModel>? leave = [
    LeaveTypeModel(title: 'Early Leave', value: 'early_leave'),
    LeaveTypeModel(title: 'Late Arrive', value: 'late_arrive'),
  ];

  FutureOr<void> _onSelectDatePicker(
      SelectDatePickerDailyLeave event, Emitter<DailyLeaveState> emit) async {
    var date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if(date != null){
      String? currentMonth = getDateAsString(format: 'y-MM-dd', dateTime: date);
      add(DailyLeaveSummary(state.selectEmployee?.id ?? event.userId));
      emit(state.copyWith(
          status: NetworkStatus.success, currentMonth: currentMonth));
    }

  }

  FutureOr<void> _dailyLeaveSummary(
      DailyLeaveSummary event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(
        status: NetworkStatus.loading,
        currentMonth: state.currentMonth ?? DateFormat('y-MM-dd').format(DateTime.now())));
    final dailyLeaveSummaryModel = await _metaClubApiClient.dailyLeaveSummary(event.userId, state.currentMonth);

    dailyLeaveSummaryModel.fold((l){emit(state.copyWith(status: NetworkStatus.failure));}, (r){
      emit(state.copyWith(
          dailyLeaveSummaryModel: r,
          status: NetworkStatus.success,
          leaveTypeModel: leave?.first));
    });
  }

  FutureOr<void> _onSelectLeaveType(SelectLeaveType event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(leaveTypeModel: event.leaveTypeModel));
  }

  FutureOr<void> _onSelectTimePicker(
      SelectApproxTime event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(approxTime: event.approxTime));
  }

  FutureOr<void> _onApplyLeave(
      ApplyLeave event, Emitter<DailyLeaveState> emit) async {
    if (state.approxTime != null && state.leaveTypeModel != null) {
      emit(state.copyWith(status: NetworkStatus.loading));
      final data = {
        'approx_time': state.approxTime,
        'reason': reasonTextController.text,
        'leave_type': state.leaveTypeModel!.value
      };
      _metaClubApiClient.postApplyLeave(data).then((data) {
        data.fold((l){
          emit(state.copyWith(status: NetworkStatus.failure));
        }, (r){
          if (r['result'] == true) {
            Fluttertoast.showToast(msg: r['message'.tr()]);
            add(DailyLeaveSummary(event.userId));
            if (event.context.mounted) {
              Navigator.of(event.context).pop();
            }
          }
        });
      });
    } else {
      Fluttertoast.showToast(msg: 'select_leave_type_and_time'.tr());
    }
  }

  FutureOr<void> _selectEmployee(
      SelectEmployee event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(selectEmployee: event.selectEmployee));
    add(DailyLeaveSummary(event.selectEmployee.id!));
  }

  Future<Either<Failure,LeaveTypeListModel?>> onLeaveTypeList(LeaveListModel leaveListModel) async {
    return await _metaClubApiClient.dailyLeaveSummaryStaffView(
        userId: state.selectEmployee?.id.toString() ?? leaveListModel.userId,
        month: leaveListModel.month,
        leaveStatus: leaveListModel.leaveStatus,
        leaveType: leaveListModel.leaveType);
  }

  void _onLeaveAction(LeaveAction event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final payload = {'leave_id': event.leaveId, 'leave_status': event.leaveStatus};
    final data = await _metaClubApiClient.dailyLeaveApprovalAction(payload);

    data.fold((l){
      Fluttertoast.showToast(msg: l.meaningfulMessage,backgroundColor: Colors.red);
      emit(state.copyWith(status: NetworkStatus.success));
    }, (r){
      if (r['result'] == true) {
        Fluttertoast.showToast(msg: r['message']);
        add(DailyLeaveSummary(state.selectEmployee?.id ?? event.userId));
        if (event.context.mounted) {
          Navigator.of(event.context).pop();
        }
      }
    });
  }
}
