import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';


part 'conference_event.dart';

part 'conference_state.dart';

class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  final MetaClubApiClient metaClubApiClient;

  ConferenceBloc({required this.metaClubApiClient})
      : super(const ConferenceState(status: NetworkStatus.loading)) {
    on<ConferenceInitialDataRequest>(_onConferenceInitialDataRequest);
    on<SelectDatePickerSchedule>(_onSelectDatePickerSchedule);
    on<SelectStartTimeConference>(_showTime);
    on<SelectEndTimeConference>(_showEndTime);
    on<SelectedEmployeeEventConference>(_onSelectedEmployee);
    on<CreateConferenceEvent>(_onCreateConferenceEvent);
  }

  FutureOr<void> _onSelectedEmployee(SelectedEmployeeEventConference event, Emitter<ConferenceState> emit) async {
    List<int> ids = [...state.selectedIds];
    List<String> users = [...state.selectedNames];
    for (var element in event.phoneBooks) {
      ids.add(element.id!);
      users.add(element.name!);
    }
    emit(state.copyWith(selectedIds: ids, selectedNames: users));
  }

  FutureOr<void> _showTime(
      SelectStartTimeConference event, Emitter<ConferenceState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
    return MediaQuery(
    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
    child: child!);
    });

    emit(state.copyWith(
      // ignore: use_build_context_synchronously
      // startTime: result?.format(event.context),
      startTime: '${result?.hour}:${result?.minute}',
    ));
  }

  FutureOr<void> _showEndTime(SelectEndTimeConference event, Emitter<ConferenceState> emit) async {
    final TimeOfDay? result = await showTimePicker(context: event.context, initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );}

    );
    emit(state.copyWith(

      // ignore: use_build_context_synchronously
      endTime:'${result?.hour}:${result?.minute}',
    ));
  }

  FutureOr<void> _onSelectDatePickerSchedule(SelectDatePickerSchedule event, Emitter<ConferenceState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonthSchedule = getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(status: NetworkStatus.success, currentMonthSchedule: currentMonthSchedule));
  }

  FutureOr<void> _onConferenceInitialDataRequest(ConferenceInitialDataRequest event, Emitter<ConferenceState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final conference = await metaClubApiClient.getConferenceList();
    conference.fold((l) {
      if(l.failureType == FailureType.httpStatus){
        if((l as GeneralFailure).httpStatusCode == 401){

        }
      }
      emit(const ConferenceState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(
          status: NetworkStatus.success, conference: r));
    });
  }

  FutureOr<void> _onCreateConferenceEvent(CreateConferenceEvent event, Emitter<ConferenceState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    metaClubApiClient.createConferenceApi(conferenceBodyModel: event.createConferenceBodyModel).then((success) {
      success.fold((l){
        emit(state.copyWith(status: NetworkStatus.failure));
      }, (r){
        if (r) {
          Fluttertoast.showToast(msg: "create_conference_successfully".tr());
          add(ConferenceInitialDataRequest());
          Navigator.pop(event.context);
        } else {
          Fluttertoast.showToast(msg: "something_went_wrong".tr());
          emit(state.copyWith(status: NetworkStatus.failure));
        }
      });
    });
  }
}
