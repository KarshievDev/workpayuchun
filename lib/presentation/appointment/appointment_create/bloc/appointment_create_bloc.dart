import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/bloc/appointment_bloc.dart';

part 'appointment_create_event.dart';

part 'appointment_create_state.dart';

class AppointmentCreateBloc extends Bloc<AppointmentCreateEvent, AppointmentCreateState> {
  final MetaClubApiClient _metaClubApiClient;
  final AppointmentBloc? _bloc;

  AppointmentCreateBloc({required MetaClubApiClient metaClubApiClient, AppointmentBloc? appointmentBloc})
      : _metaClubApiClient = metaClubApiClient,
        _bloc = appointmentBloc,
        super(const AppointmentCreateState(
          status: NetworkStatus.initial,
        )) {
    on<LoadAppointmentCreateData>(_onAppointmentDataLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<SelectStartTime>(_showTime);
    on<SelectEndTime>(_showEndTime);
    on<CreateButton>(_onCreateButton);
    on<SelectEmployee>(_selectEmployee);
  }

  void _onAppointmentDataLoad(LoadAppointmentCreateData event, Emitter<AppointmentCreateState> emit) async {
    emit(AppointmentCreateState(
      status: NetworkStatus.success,
      currentMonth: event.date,
      startTime: event.startTime,
      endTime: event.endTime,
    ));
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<AppointmentCreateState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _showTime(SelectStartTime event, Emitter<AppointmentCreateState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
    );
    if (event.context.mounted) {
      emit(state.copyWith(startTime: result?.format(event.context)));
    }
  }

  FutureOr<void> _selectEmployee(SelectEmployee event, Emitter<AppointmentCreateState> emit) async {
    emit(state.copyWith(selectedEmployee: event.selectEmployee));
  }

  FutureOr<void> _showEndTime(SelectEndTime event, Emitter<AppointmentCreateState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      initialTime: TimeOfDay.now(),
    );
    if (event.context.mounted) {
      emit(state.copyWith(endTime: result?.format(event.context)));
    }
  }

  FutureOr<void> _onCreateButton(CreateButton event, Emitter<AppointmentCreateState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient.appointmentCreate(appointmentBody: event.appointmentBody).then((success) {
        Fluttertoast.showToast(
          msg: success.toString(),
        );
        _bloc?.add(GetAppointmentData());
        if(event.context.mounted) {
          Navigator.pop(event.context);
        }
      });
      emit(state.copyWith(status: NetworkStatus.success));
      // ignore: use_build_context_synchronously
    } catch (e) {
      emit(const AppointmentCreateState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
