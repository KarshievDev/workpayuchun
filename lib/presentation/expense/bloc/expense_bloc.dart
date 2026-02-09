import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final MetaClubApiClient _metaClubApiClient;

  ExpenseBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const ExpenseState(status: NetworkStatus.initial)) {
    on<GetExpenseData>(_onExpenseDataLoad);
    on<SelectMonthPicker>(_onSelectMonthPicker);
    on<SelectPaymentType>(_onSelectedPaymentType);
    on<SelectStatus>(_onSelectedStatus);
    on<ExpenseCategory>(_onExpenseCategoryLoad);
    on<SelectedCategory>(_onSelectedCategory);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<ExpenseCreateButton>(_onCreateButton);
  }

  FutureOr<void> _onExpenseDataLoad(GetExpenseData event, Emitter<ExpenseState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    emit(state.copy(
        status: NetworkStatus.loading,
        currentMonth: event.date,
        statusType: event.statusTypeId,
        paymentId: event.paymentId));
    final responseExpenseList =
        await _metaClubApiClient.getExpenseItem(state.currentMonth ?? currentDate, state.paymentId, state.statusType);
    responseExpenseList.fold((l) {
      emit(state.copy(status: NetworkStatus.failure));
    }, (r) {
      if (r != null) {
        emit(state.copy(status: NetworkStatus.success, responseExpenseList: r));
      } else {
        emit(state.copy(status: NetworkStatus.failure));
      }
    });
  }

  FutureOr<void> _onSelectMonthPicker(SelectMonthPicker event, Emitter<ExpenseState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (date != null) {
      String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
      add(GetExpenseData(date: currentMonth));
    }
  }

  FutureOr<void> _onSelectedPaymentType(SelectPaymentType event, Emitter<ExpenseState> emit) {
    emit(state.copy(paymentTypeName: event.paymentType));
    int paymentTypeId;

    if (event.paymentType == 'Paid') {
      paymentTypeId = 8;
    } else {
      paymentTypeId = 9;
    }

    add(GetExpenseData(paymentId: paymentTypeId.toString()));
  }

  FutureOr<void> _onSelectedStatus(SelectStatus event, Emitter<ExpenseState> emit) {
    emit(state.copy(
      statusTypeName: event.statusType,
    ));
    int status;
    if (event.statusType == 'Pending') {
      status = 2;
    } else if (event.statusType == 'Approved') {
      status = 5;
    } else {
      status = 6;
    }
    add(GetExpenseData(
      statusTypeId: status.toString(),
    ));
  }

  FutureOr<void> _onExpenseCategoryLoad(ExpenseCategory event, Emitter<ExpenseState> emit) async {
    emit(state.copy(
      status: NetworkStatus.loading,
    ));
    final expenseCategoryData = await _metaClubApiClient.getExpenseCategory();
    expenseCategoryData.fold((l) {
      emit(state.copy(
        status: NetworkStatus.failure,
      ));
    }, (r) {
      emit(state.copy(status: NetworkStatus.success, expenseCategoryData: r));
    });
  }

  FutureOr<void> _onSelectedCategory(SelectedCategory event, Emitter<ExpenseState> emit) {
    emit(state.copy(selectedCategory: event.selectedCategory));
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<ExpenseState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (date != null) {
      String? currentDate = getDateAsString(format: 'dd-MM-yyyy', dateTime: date);
      emit(state.copy(selectDate: currentDate));
    }
  }

  FutureOr<void> _onCreateButton(ExpenseCreateButton event, Emitter<ExpenseState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    _metaClubApiClient.expenseCreate(expenseCreateBody: event.expenseCreateBody).then((expanse) {
      expanse.fold((l) {
        emit(state.copy(status: NetworkStatus.failure));
      }, (r) {
        Fluttertoast.showToast(msg: r.message);
        if (r.success) {
          add(GetExpenseData());
          Navigator.pop(event.context);
        }
      });
    });
  }
}
