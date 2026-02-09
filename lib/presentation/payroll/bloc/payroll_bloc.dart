import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/dialogs/custom_dialogs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payroll_event.dart';

part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final MetaClubApiClient metaClubApiClient;

  PayrollBloc({required this.metaClubApiClient}) : super(const PayrollState(status: NetworkStatus.initial)) {
    on<PayrollInitialDataRequest>(_onPayrollDataInitialDataRequest);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onPayrollDataInitialDataRequest(PayrollInitialDataRequest event, Emitter<PayrollState> emit) async {
    final currentDate = DateFormat('y').format(DateTime.now());
    final payrollData = await metaClubApiClient.getPayrollData(year: event.setDate ?? currentDate);
    payrollData.fold((l) {
      emit(const PayrollState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(
          dateTime: event.setDate != null ? DateFormat("y").parse(event.setDate!) : DateFormat("y").parse(currentDate),
          status: NetworkStatus.success,
          payroll: r,
          isLoading: false));
    });
  }

  getPaySlip(String link) async {
    launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication).onError(
      (error, stackTrace) {
        debugPrint("Url is not valid!");
        return false;
      },
    );
  }

  sharePaySlip(String link) async {
    await Share.share(link);
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<PayrollState> emit) async {
    showYearPicker(
      context: event.context,
      initialDate: DateTime.now(),
      selectDate: state.dateTime ?? DateTime.now(),
      onDatePicked: (DateTime dateTime) async {
        String? currentMonth = getDateAsString(format: 'y', dateTime: dateTime);
        add(PayrollInitialDataRequest(setDate: currentMonth));
        if (event.context.mounted) {
          Navigator.pop(event.context);
        }
      },
    );
  }
}
