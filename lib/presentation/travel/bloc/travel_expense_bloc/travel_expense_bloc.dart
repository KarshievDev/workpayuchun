import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

part 'travel_expense_event.dart';
part 'travel_expense_state.dart';

typedef TravelExpenseBlocFactory = TravelExpenseBloc Function({required TravelPlanItem travelPlanItem});

class TravelExpenseBloc extends Bloc<TravelExpenseEvent, TravelExpenseState> {
  final LoadTravelCategoriesUseCase loadTravelCategoriesUseCase;
  final LoadTravelModeUseCase loadTravelModeUseCase;
  final LoadTravelExpenseUseCase loadTravelExpenseUseCase;
  final SubmitTravelExpenseUseCase submitTravelExpenseUseCase;
  final TravelPlanItem travelPlanItem;
  final TextEditingController fromLocationController = TextEditingController();
  final TextEditingController toLocationController = TextEditingController();
  final TextEditingController travelPurposeController = TextEditingController();
  final TextEditingController amountRequiredController = TextEditingController();

  TravelExpenseBloc(
      {required this.loadTravelCategoriesUseCase,
      required this.loadTravelModeUseCase,
      required this.loadTravelExpenseUseCase,
      required this.submitTravelExpenseUseCase,
      required this.travelPlanItem})
      : super(const TravelExpenseState(status: NetworkStatus.initial)) {
    on<TravelExpenseEventLoad>(_onTravelExpenseLoad);
    on<OnTravelModeLoadEvent>(_onTravelModeLoad);
    on<TravelModeEvent>(_onTravelModeChanged);
    on<TravelCategoryEvent>(_onTravelCategoryLoad);
    on<OnSelectDate>(_onSelectDate);
    on<OnExpenseSubmit>(_onTravelExpenseSubmit);
    on<OnReviewChanged>(_onReviewChanged);

    add(OnTravelModeLoadEvent());
    add(TravelCategoryEvent());
    add(TravelExpenseEventLoad());
  }

  void _onSelectDate(OnSelectDate event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(date: event.date));
  }

  void _onTravelExpenseSubmit(OnExpenseSubmit event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final body = TravelPlanExpenseBody(
        date: state.date,
        travelId: travelPlanItem.id,
        fileIds: event.fileIds,
        modeOfTransportation: state.modeOfTransportation,
        rating: state.rating,
        categoryIds: event.cIds,
        amounts: event.amounts,
        remarks: event.remarks);
    final data = await submitTravelExpenseUseCase(body: body);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      Navigator.pop(event.context);
      add(TravelExpenseEventLoad());
    });
  }

  FutureOr<void> _onTravelExpenseLoad(TravelExpenseEventLoad event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final loadTravels = await loadTravelExpenseUseCase(travelPlanId: travelPlanItem.id!);
    loadTravels.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(travelExpense: r, status: NetworkStatus.success));
    });
  }

  FutureOr<void> _onTravelModeLoad(OnTravelModeLoadEvent event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final modes = await loadTravelModeUseCase();
    modes.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(modes: r, status: NetworkStatus.success));
    });
  }

  FutureOr<void> _onTravelModeChanged(TravelModeEvent event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(modeOfTransportation: event.mode));
  }

  FutureOr<void> _onTravelCategoryLoad(TravelCategoryEvent event, Emitter<TravelExpenseState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final modes = await loadTravelCategoriesUseCase();
    modes.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(categories: r, status: NetworkStatus.success));
    });
  }

  FutureOr<void> _onReviewChanged(OnReviewChanged event, Emitter<TravelExpenseState> emit) {
    emit(state.copyWith(rating: event.rating));
  }
}
