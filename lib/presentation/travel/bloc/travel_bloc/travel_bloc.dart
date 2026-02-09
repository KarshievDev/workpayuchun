import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

part 'travel_event.dart';

part 'travel_state.dart';

typedef TravelBlocFactory = TravelBloc Function();

class TravelBloc extends Bloc<TravelEvent, TravelState> {
  final LoadTravelPlanUseCase loadTravelPlanUseCase;
  final SubmitTravelPlanUseCase submitTravelPlanRequest;
  final TextEditingController fromLocationController = TextEditingController();
  final TextEditingController toLocationController = TextEditingController();
  final TextEditingController travelPurposeController = TextEditingController();
  final TextEditingController amountRequiredController = TextEditingController();

  TravelBloc({required this.loadTravelPlanUseCase, required this.submitTravelPlanRequest})
      : super(const TravelState(status: NetworkStatus.initial)) {
    on<TravelPlanEventLoad>(_onTravelPlanLoad);
    on<OnSelectFromDate>(_onSelectFromDate);
    on<OnSelectToDate>(_onSelectToDate);
    on<OnSelectSignedDate>(_onSelectSignedDate);
    on<SubmitButton>(_onTravelPlanSubmit);

    add(TravelPlanEventLoad());
  }

  Future<String?> conventDataToBase64() async {
    ui.Image image = await state.signaturePadKey!.currentState!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List imageBytes = byteData.buffer.asUint8List();
      return base64Encode(imageBytes);
    }
    return null;
  }

  void _onSelectFromDate(OnSelectFromDate event, Emitter<TravelState> emit) async {
    emit(state.copyWith(fromDate: event.fromDate));
  }

  void _onSelectToDate(OnSelectToDate event, Emitter<TravelState> emit) async {
    emit(state.copyWith(toDate: event.toDate));
  }

  void _onSelectSignedDate(OnSelectSignedDate event, Emitter<TravelState> emit) async {
    emit(state.copyWith(signedDate: event.signedDate));
  }

  void _onTravelPlanSubmit(SubmitButton event, Emitter<TravelState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, signaturePadKey: event.signaturePadKey));
    final base64String = await conventDataToBase64();
    final body = TravelPlanBody(
        fromDate: state.fromDate,
        toDate: state.toDate,
        fromLocation: fromLocationController.text,
        toLocation: toLocationController.text,
        purpose: travelPurposeController.text,
        amount: amountRequiredController.text,
        signatureDate: state.signedDate,
        signature: "data:image/png;base64,$base64String");
    final data = await submitTravelPlanRequest(body: body);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      Navigator.pop(event.context);
      add(TravelPlanEventLoad());
    });
  }

  FutureOr<void> _onTravelPlanLoad(TravelPlanEventLoad event, Emitter<TravelState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final loadTravels = await loadTravelPlanUseCase();
    loadTravels.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(travelPlanModel: r, status: NetworkStatus.success));
    });
  }
}
