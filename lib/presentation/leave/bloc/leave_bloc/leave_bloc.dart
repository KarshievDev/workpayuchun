import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'leave_event.dart';

part 'leave_state.dart';

typedef FactoryLeaveBloc = LeaveBloc Function();

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LoadLeaveRequestDataUseCase loadLeaveRequestDataUseCase;
  final LoadLeaveRequestTypeUseCase loadLeaveRequestTypeUseCase;
  final SubmitLeaveRequestUseCase submitLeaveRequestUseCase;
  final LoadLeaveSummeryDataUseCase loadLeaveSummeryDataUseCase;

  LeaveBloc({
    required this.loadLeaveRequestDataUseCase,
    required this.loadLeaveRequestTypeUseCase,
    required this.submitLeaveRequestUseCase,
    required this.loadLeaveSummeryDataUseCase,
  }) : super(const LeaveState(status: NetworkStatus.initial)) {
    on<LeaveSummaryApi>(_leaveSummaryApi);
    on<LeaveRequest>(_leaveRequest);
    on<LeaveRequestTypeEvent>(_leaveRequestTypeApi);
    on<SelectedRequestType>(_selectedRequestType);
    on<SelectedCalendar>(_selectedCalendar);
    on<SelectEmployee>(_selectEmployee);
    on<SubmitLeaveRequest>(_submitLeaveRequest);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onSelectDatePicker(
    SelectDatePicker event,
    Emitter<LeaveState> emit,
  ) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (date != null) {
      String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
      add(LeaveRequest(event.userId));
      emit(
        state.copyWith(
          status: NetworkStatus.success,
          currentMonth: currentMonth,
        ),
      );
    }
  }

  FutureOr<void> _submitLeaveRequest(
    SubmitLeaveRequest event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    await submitLeaveRequestUseCase(body: event.bodyCreateLeaveModel).then((
      success,
    ) {
      success.fold(
        (l) {
          emit(state.copyWith(status: NetworkStatus.failure));
        },
        (r) {
          if (r) {
            Fluttertoast.showToast(
              msg: "leave_request_create_successfully".tr(),
            );
            emit(state.copyWith(status: NetworkStatus.success));
            add(LeaveRequest(event.uid));
            Navigator.pop(event.context);
          } else {
            emit(state.copyWith(status: NetworkStatus.failure));
            Fluttertoast.showToast(msg: "Something went wrong!");
          }
        },
      );
    });
  }

  FutureOr<void> _leaveRequestTypeApi(
    LeaveRequestTypeEvent? event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final leaveRequestTypeResponse = await loadLeaveRequestTypeUseCase(
      uid: event!.userId,
    );
    leaveRequestTypeResponse.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        emit(
          state.copyWith(leaveRequestType: r, status: NetworkStatus.success),
        );
      },
    );
  }

  FutureOr<void> _leaveRequest(
    LeaveRequest event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final leaveRequestResponse = await loadLeaveRequestDataUseCase(
      uid: event.userId,
      cMonth: state.currentMonth ?? DateFormat('y-MM').format(DateTime.now()),
    );
    leaveRequestResponse.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        emit(
          state.copyWith(leaveRequestModel: r, status: NetworkStatus.success),
        );
      },
    );
  }

  FutureOr<void> _leaveSummaryApi(
    LeaveSummaryApi event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final leaveSummaryResponse = await loadLeaveSummeryDataUseCase(
      uid: event.userId,
    );
    leaveSummaryResponse.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        emit(
          state.copyWith(leaveSummaryModel: r, status: NetworkStatus.success),
        );
      },
    );
  }

  FutureOr<void> _selectedRequestType(
    SelectedRequestType event,
    Emitter<LeaveState> emit,
  ) {
    emit(state.copyWith(selectedRequestType: event.availableLeaveType));
  }

  FutureOr<void> _selectedCalendar(
    SelectedCalendar event,
    Emitter<LeaveState> emit,
  ) {
    emit(state.copyWith(startDate: event.startDate, endDate: event.endDate));
  }

  FutureOr<void> _selectEmployee(
    SelectEmployee event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(selectedEmployee: event.selectEmployee));
  }
}
