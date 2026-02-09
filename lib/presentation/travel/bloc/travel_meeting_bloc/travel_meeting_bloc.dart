import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/date_utils.dart';

part 'travel_meeting_state.dart';

part 'travel_meeting_event.dart';

typedef TravelMeetingBlocFactory = TravelMeetingBloc Function({required TravelPlanItem travelPlanItem});

class TravelMeetingBloc extends Bloc<TravelMeetingEvent, TravelMeetingState> {
  final LoadTravelMeetingUseCase loadTravelMeetingUseCase;
  final SubmitTravelMeetingUseCase submitTravelMeetingUseCase;
  final TravelPlanItem travelPlanItem;
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController purposeOfTravelController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  double? ratingCount = 0.0;
  int? fileId;

  TravelMeetingBloc(
      {required this.loadTravelMeetingUseCase, required this.travelPlanItem, required this.submitTravelMeetingUseCase})
      : super(const TravelMeetingState(status: NetworkStatus.initial)) {
    on<TravelMeetingEventLoad>(_onTravelMeetingLoad);
    on<OnSelectTravelDate>(_onSelectTravelDate);
    on<OnSelectScheduleTime>(_onSelectScheduleTime);
    on<OnSelectStartTime>(_onSelectStringTime);
    on<OnSelectEndTime>(_onSelectEndTime);
    on<SubmitButton>(_onTravelMeetingSubmit);
    on<OnReviewChanged>(_onReviewChanged);

    add(TravelMeetingEventLoad());
  }

  FutureOr<void> _onReviewChanged(OnReviewChanged event, Emitter<TravelMeetingState> emit) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onSelectTravelDate(OnSelectTravelDate event, Emitter<TravelMeetingState> emit) async {
    emit(state.copyWith(travelDate: event.travelDate));
  }

  void _onSelectScheduleTime(OnSelectScheduleTime event, Emitter<TravelMeetingState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (event.context.mounted) {
      emit(state.copyWith(scheduleTime: result?.format(event.context)));
    }
  }

  void _onSelectStringTime(OnSelectStartTime event, Emitter<TravelMeetingState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (event.context.mounted) {
      emit(state.copyWith(startTime: result?.format(event.context)));
    }
  }

  void _onSelectEndTime(OnSelectEndTime event, Emitter<TravelMeetingState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (event.context.mounted) {
      emit(state.copyWith(endTime: result?.format(event.context)));
    }
  }

  FutureOr<void> _onTravelMeetingLoad(TravelMeetingEventLoad event, Emitter<TravelMeetingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final loadTravels = await loadTravelMeetingUseCase(travelPlanId: travelPlanItem.id!);
    loadTravels.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(travelMeetingModel: r, status: NetworkStatus.success));
    });
  }

  void _onTravelMeetingSubmit(SubmitButton event, Emitter<TravelMeetingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final body = CreateTravelMeetingBody(
        travelPlanId: travelPlanItem.id,
        date: state.travelDate,
        meetingScheduleTime: get24HTime(timeOfDay: state.scheduleTime),
        meetingStartTime: get24HTime(timeOfDay: state.startTime),
        meetingEndTime: get24HTime(timeOfDay: state.endTime),
        customerCompanyName: companyNameController.text,
        customerName: nameController.text,
        customerEmail: emailController.text,
        customerPhone: phoneNumberController.text,
        purpose: purposeOfTravelController.text,
        remark: remarkController.text,
        fileId: fileId,
        rating: state.rating);
    final data = await submitTravelMeetingUseCase(body: body);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, errorMsg: l.meaningfulMessage));
    }, (r) {
      emit(state.reset());
      dispose();
      add(TravelMeetingEventLoad());
      Navigator.pop(event.context);
    });
  }

  void dispose() {
    companyNameController.clear();
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    purposeOfTravelController.clear();
    remarkController.clear();
  }
}
